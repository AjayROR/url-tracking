class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :urls

  def full_url?
    self.urls.size >= URL_LIMIT
  end

  def last_updated_url
    urls.last_updated.first
  end

end
