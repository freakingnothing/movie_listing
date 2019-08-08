class Scraper::KinopoiskScraper < Scraper::BaseScraper
  attr_accessor :info_table

  def get_info_table(page)
    @info_table = page.css("table[class='info']")
  end

  def get_info(info_table)
    @info = {}

    info_table.css('tr').each {|tr| info[tr.css('td')[0].text] = tr.css('td')[1].text.strip}
  end

  def get_rus_title
    page.css("h1[class='moviename-big']").text
  end

  def get_original_title
    page.css("span[class='alternativeHeadline']").text
  end

  def get_rating
    page.css("span[class='rating_ball']").text
  end

  def get_release_year
    info["год"].split.join(' ')
  end

  def get_country
    info["страна"].split(',').each {|word| word.strip!}.join(', ')
  end

  def get_genre
    info["жанр"].split(',').map {|word| word.strip}[0...-1].join(', ')
  end

  def perform
    get_page(url)
    get_info_table(page)
    get_info(info_table)

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
