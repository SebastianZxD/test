class Newlink < ApplicationRecord
	validates_presence_of :url
  validates :url, format: URI::regexp(%w[http https])
  validates_uniqueness_of :slug
  validates_length_of :url, within: 3..255, on: :create, message: "too long"
  validates_length_of :slug, within: 3..255, on: :create, message: "too long"
  before_validation :encrypt, :on => :create
  
	def encrypt
		self.slug = SecureRandom.alphanumeric(5) if self.slug.nil? || self.slug.empty?
	  true
	end

end
