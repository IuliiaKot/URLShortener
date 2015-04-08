class ShortenedUrl < ActiveRecord::Base
  validates :email, :presence => true, :email => true,
end
