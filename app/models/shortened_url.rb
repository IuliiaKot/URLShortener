require 'sqlite3'

class ShortenedUrl < ActiveRecord::Base
  validates :submitter_id, :presence => true, :uniqueness => true
  validates :short_url, :presence => true, :uniqueness => true

  belongs_to(
    :submitter,
    :class_name => "User",
    :foreign_key => :submitter_id,
    :primary_key => :id
  )

  has_many(
    :visits,
    :class_name => "Visit",
    :foreign_key => :short_url_id,
    :primary_key => :id
  )

  has_many :visitors, :through => :visits, :source => :visitor

  has_many(
    :distinct_visits,
    -> { distinct },
    through: :visits,
    source: :visitor
  )
  def self.create_for_user_and_long_url!(user_id, long_url)
    short_url = self.random_code
    ShortenedUrl.create!({
      :submitter_id => user_id,
      :short_url => short_url,
      :long_url => long_url })
  end

  def self.random_code
    code = SecureRandom.urlsafe_base64
    random_code if ShortenedUrl.exists?(short_url: code)
    code
  end

  def num_clicks
    self.visits.select(:visitor_id).count
  end

  def num_unique
    self.distinct_visits.select(:visitor_id).count
  end

  def num_recent_uniques
    self.distinct_visits.where(created_at: 10.minutes.ago).select(:visitor_id).count
  end

end
