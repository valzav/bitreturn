class BitcoinBlocksImporter

  def initialize(url)
    last_block = Bitcoin::Block.last
    @last_block_number = last_block ? last_block.block_number : 0
    @last_block_date = Date.new(0)
    @curl = Curl::Easy.new
    @curl.follow_location = true
    @curl.max_redirects = 3
    @curl.useragent = 'Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2 GTB5'
    @curl.url = url
  end

  def parse_csv_line(l)
    # blockNumber,time,target,avgTargetSinceLast,difficulty,hashesToWin,avgIntervalSinceLast,netHashPerSecond
    data = l.strip.split(',')
    block_time = Time.at(data[1].to_i)
    attrs = {
      block_number: data[0].to_i,
      block_date: block_time.to_date,
      block_time: block_time,
      target: data[2],
      difficulty: data[4],
      ghps: data[7].to_f / 1000000000.0
    }
    return attrs
  end

  def create_block_from_csv_line(l)
    attrs = parse_csv_line(l)
    return false if attrs[:block_number] <= @last_block_number
    return false if attrs[:block_date] <= @last_block_date
    @last_block_number = attrs[:block_number]
    @last_block_date = attrs[:block_date]
    Bitcoin::Block.create!(attrs)
    return true
  end

  def for_each_line_in(data)
    line = ''
    for i in 0..(data.length-1)
      c = data[i]
      if c == "\n"
        yield line
        line = ''
      else
        line << c
      end
    end
    yield line unless line.empty?
  end

  def perform
    @curl.perform
    data = @curl.body_str

    counter = 0
    start = false
    self.for_each_line_in data do |l|
      if l == 'START DATA'
        start = true
        next
      end
      next unless start
      res = create_block_from_csv_line l
      counter +=1 if res
      #break if counter > 10
    end

    return counter
  end


end
