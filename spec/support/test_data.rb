module TestData

  def filepath(filename)
    Rails.root.join('spec/test_data/', filename)
  end

  def load_yaml(filename)
    YAML::load(File.open(filepath(filename)))
  end

  def load_text(filename)
    r = nil
    File.open(filepath(filename)) { |f| r = f.read }
    r
  end

  def load_json(filename)
    r = nil
    File.open(filepath(filename)) { |f| r = f.read }
    ActiveSupport::JSON.decode(r)
  end

  def for_each_line_in_csv(filename)
    File.open(filepath(filename)) do |f|
      f.each_line{|l| yield l}
    end
  end

  def website_data_file_path(file)
    'file://' + Rails.root.join('spec/test_data/websites', file).to_s
  end

end
