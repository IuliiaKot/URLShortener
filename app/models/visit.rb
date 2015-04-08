class Visit < ActiveRecord::Base
  validates :visitor_id, :presence => true
  validates :short_url, :presence => true

  # has_many(
  #   :shortened_urls,
  #   :class_name => "ShortenedUrl",
  #   :foreign_key => :submitter_id,
  #   :primary_key => :id
  # )

  def self.record_visit!(user, short_url)
    Visit.create!({
      :visitor_id => user,
      :short_url => short_url })
  end
end
