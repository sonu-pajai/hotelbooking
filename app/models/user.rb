class User < ActiveRecord::Base

  has_many :bookings
  devise :database_authenticatable, :registerable, :rememberable
end
