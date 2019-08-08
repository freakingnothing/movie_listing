class Scraper::ImdbScraper < Scraper::BaseScraper
  def get_info(page)
    @info = page.css("div[class='media-body']")
  end

  def get_original_title
    @info.css('h1').text.gsub(/\((\d|–)*\)/, '').strip
  end

  def get_rating
    page.css('div#ratings-bar').css("span")[1].text.gsub(/\/|(?<=\/).*$/, '')
  end

  def get_release_year
    @info.css("small[class='sub-header']").text.gsub(/[\(\)]/, '').strip
  end

  def get_country
    page.css('section').select {|s| s.css('h3').text.strip == "Country of Origin"}.last.text.gsub("Country of Origin", '').gsub("\n", ' ').strip
  end

  def get_genre
    info.css("span[itemprop='genre']").map {|name| name.text.downcase }.join(', ')
  end

  def perform
    get_page(url)
    get_info(page)

    result = {
      original_title: get_original_title,
      rating: get_rating,
      release_year: get_release_year,
      country: get_country,
      genre: get_genre
    }
  end
end
