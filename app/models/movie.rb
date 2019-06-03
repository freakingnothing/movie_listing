class Movie < ApplicationRecord
  has_many :listings
  has_many :lists, through: :listings

  validates :url, presence: true

  def find_existing_movie 
    Movie.where(url: self.sanitize_url).first
  end  

  def is_new?
    find_existing_movie.nil?
  end

  def sanitize_url
    uri = URI.parse(self.url)
    self.url = "http://#{uri.host + uri.path}"
  end

  def convert_imdb_url_to_mobile_imdb_url
    uri = URI.parse(self.url)
    self.mobile_url = "http://m.imdb.com#{uri.path}"
  end
end
