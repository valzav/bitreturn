class Og
  attr_accessor :fb_app_id, :type, :title, :description, :image, :longitude, :latitude, :url, :site_name

  def initialize(params=nil)
    if params
      @fb_app_id = params[:fb_app_id]
      # @fb_app_id = 220452988051469
      @type = params[:type]
      @title = params[:title]
      @description = params[:description]
      @image = params[:image]
      @latitude = params[:latitude]
      @longitude = params[:longitude]
      @url = params[:url]
      @site_name = params[:site_name]
    end
  end

  def facebook_og_metas
    output = ""
    output << %{<meta property="fb:app_id" content="#{@fb_app_id}"/>\n} if @fb_app_id
    output << %{<meta property="og:type" content="#{@type}"/>\n} if @type
    output << %{<meta property="og:url" content="#{@url}"/>\n} if @url
    output << %{<meta property="og:title" content="#{@title}"/>\n} if @title
    output << %{<meta property="og:description" content="#{@description}"/>\n} if @description
    output << %{<meta property="og:image" content="#{@image}"/>\n} if @image
    output << %{<meta property="og:site_name" content="#{@site_name}"/>\n} if @site_name
    return output
  end

  def twitter_card_metas
    output = ""
    output << %{<meta property="twitter:card" content="product"/>\n}
    output << %{<meta property="twitter:site" content="@etsonic"/>\n}
    output << %{<meta property="twitter:title" content="#{@title}"/>\n} if @title
    output << %{<meta property="twitter:description" content="#{@description}"/>\n} if @description
    output << %{<meta property="twitter:image" content="#{@image}"/>\n} if @image
    return output

  end

end
