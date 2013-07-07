module ApplicationHelper

  def title(value)
    @title = value
  end

  def get_title
    prefix = Rails.env.development? ? '[DEV] ' : ''
    if @title
      "#{prefix}#{@title} - BitReturn"
    else
      "#{prefix}BitReturn"
    end
  end

  def nav_section_class(section)
    if @navsection == section
      'class="active"'.html_safe
    else
      ''
    end
  end

  def flash_class(level)
    case level
      when :notice then
        "alert-success"
      when :error then
        "alert-error"
      when :alert then
        ""
    end
  end

  def mf(amount,precision=4)
    af = amount.to_f
    return '0.0' if af == 0.0
    ("%.#{precision}f" % amount.to_f).sub(/0+$/, '')
  end

  def show_page(url, title)
    res = <<-eos
      #{title}
      <a class="page-url" href="#{url}" title="#{url}" target="_blank">
        <i class="icon-external-link"></i>
      </a>
    eos
    res.html_safe
  end

end
