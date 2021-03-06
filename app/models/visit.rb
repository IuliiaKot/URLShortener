

class Visit < ActiveRecord::Base
  validates :visitor_id, :presence => true
  validates :short_url_id, :presence => true

  belongs_to(
    :visitor,
    :class_name => "User",
    :foreign_key => :visitor_id,
    :primary_key => :id
  )


  belongs_to(
    :visited_url,
    :class_name => "ShortenedUrl",
    :foreign_key => :short_url_id,
    :primary_key => :id
  )

  def self.record_visit!(user, short_url_id)
    Visit.create!({
      :visitor_id => user,
      :short_url_id => short_url_id })
  end
end
