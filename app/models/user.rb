class User < ActiveRecord::Base
  validates :email, :presence => true, :email => true

  has_many(
    :shortened_urls,
    :class_name => "ShortenedUrl",
    :foreign_key => :submitter_id,
    :primary_key => :id
  )
end
