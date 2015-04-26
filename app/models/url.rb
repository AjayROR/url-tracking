require 'internet/connectivity'

class Url < ActiveRecord::Base
  include StripInputs

  before_validation :strip_inputs

  belongs_to :user

  # validate :url_limit
  validates_presence_of :address
  validates_uniqueness_of :address

  scope :last_updated, -> {
    order('updated_at DESC, created_at DESC').limit(1)
  }

  scope :all_urls, -> { select('id, address, status') }

  scope :total_urls ,-> { all.size }

  # Method will verify & update the health of each url
  def self.verify_status
    all_urls.each do |url|
      begin
        url.found? ? url.mark_valid : url.mark_invalid
      rescue Exception => error
        puts logger.error error.message
        url.mark_invalid unless Internet::Connectivity.failure?
      end
    end
  end

  # if not found then mark Invalid / false
  def mark_invalid
    update_attributes(status: false)
  end

  # if found then mark Valid / true
  def mark_valid
    update_attributes(status: true)
  end

  # Method will verify specific url is found or not(comparing status to 200)
  def found?
    RestClient.head(address).code  == 200
  end

  private
  # validation on url limit
  def url_limit
    if url_full?
      errors.add(:base, "Sorry, Maximum #{URL_LIMIT} urls can only be registered.")
      false
    end
  end

  # Verifies wether total number of urls has touched the max limit or not
  def url_full?
    Url.total_urls == URL_LIMIT
  end
end