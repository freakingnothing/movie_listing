class Scraper::KinopoiskMobileScraper < Scraper::BaseScraper
  def get_page(url)
    @page = Nokogiri::HTML(RestClient::Request.execute(
      method: :get,
      url: url,
      headers: {
        'User-Agent' => 'Mozilla/5.0 (Linux; Android 8.0.0; Pixel 2 XL Build/OPD1.170816.004) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.131 Mobile Safari/537.36'
      }
    ))
  end

  def get_info(page)
    @info = page.css("div[class='movie-header__details']")
  end

  def get_rus_title
    @info.css("h1[class='movie-header__title']").text.strip
  end

  def get_original_title
    @info.css("h2[class='movie-header__original-title']").text.strip
  end

  def get_rating
    @page.css("span[class='movie-rating__value movie-rating__value_type_positive']").text.strip
  end

  def get_release_year
    @info.css("span[class='movie-header__years']").text.strip
  end

  def get_country
    @info.css("p[class='movie-header__production']").text.strip.split(', ')[0...-1].join(', ')
  end

  def get_genre
    @info.css("p[class='movie-header__genres']").text.strip
  end

  def perform
    get_page(url)
    get_info(page)

    result = {
      rus_title: get_rus_title,
      original_title: get_original_title,
      rating: get_rating,
      release_year: get_release_year,
      country: get_country,
      genre: get_genre
    }
  end
end
