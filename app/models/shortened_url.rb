class ShortenedUrl < ActiveRecord::Base
  validates :submitter_id, :presence => true, :uniqueness => true
  validates :short_url, :presence => true, :uniqueness => true

  belongs_to(
    :submitter,
    :class_name => "User",
    :foreign_key => :submitter_id,
    :primary_key => :id
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

end
