class Token < ApplicationRecord
  has_many :visits

  validates_presence_of :url
  validates_uniqueness_of :url, :token
  validates :url, format: URI::DEFAULT_PARSER.make_regexp(%w[http https])
end
