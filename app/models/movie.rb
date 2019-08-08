class Movie < ApplicationRecord
  has_many :listings, dependent: :destroy
  has_many :lists, through: :listings

  validates :url, presence: true

  scope :completed_all, -> (user) { joins(:lists).where(lists: {user_id: user.id}).merge(Listing.completed).distinct }
  scope :completed, -> { merge(Listing.completed) }
  scope :active, -> { merge(Listing.active) }

  def find_listing(list)
    self.listings.where(list_id: list.id).first
  end

  def toggle_status(list)
    status = find_listing(list)
    status.completed? ? status.activate! : status.complete!
  end

  def can_complete?(list)
    find_listing(list).may_complete?
  end

  def find_existing_movie
    Movie.where(url: self.sanitize_url).first
  end

  def is_new?
    find_existing_movie.nil?
  end

  def not_in_list?(list)
    find_existing_movie.lists.find_by(id: list.id).nil?
  end

  def sanitize_url
    uri = URI.parse(self.url)
    self.url = "http://#{uri.host + uri.path}"
  end

  def add_source
    self.source = check_source
  end

  def check_source
    if self.url.include?('kinopoisk')
      'Kinopoisk'
    elsif self.url.include?('imdb')
      'IMDb'
    else
      'None'
    end
  end

  def convert_imdb_url_to_mobile_imdb_url
    uri = URI.parse(self.url)
    self.mobile_url = "http://m.imdb.com#{uri.path}"
  end

  def add_mobile_url
    check_source == 'IMDb' ? convert_imdb_url_to_mobile_imdb_url : self.mobile_url = self.url
  end

  def scrape_movie_kinopoisk
    kinopoisk_scrape = Scraper::KinopoiskMobileScraper.new(self.mobile_url)
    result = kinopoisk_scrape.perform
  end

  def scrape_movie_imdb
    imdb_scrape = Scraper::ImdbScraper.new(self.mobile_url)
    result = imdb_scrape.perform
  end

  def scrape_movie
    source = check_source

    case source
    when 'Kinopoisk'
      scrape_movie_kinopoisk
    when 'IMDb'
      scrape_movie_imdb
    else
      nil
    end
  end

  def add_scraper_result
    scraper_result = self.scrape_movie
    scraper_result.each {|key, val| self[key] = val}
  end
end

