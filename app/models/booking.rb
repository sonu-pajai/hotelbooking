class Booking < ActiveRecord::Base

	enum room_type: ["Deluxe Rooms", "Luxury Rooms", "Luxury suites", "Presidential Suites"]

	belongs_to :room
  belongs_to :user

  before_validation :check_room_availability

	validate :validate_dates
  validates :user_id, :start_date, :last_date, presence: true
  validates_format_of :start_date, :last_date, :with => /\d{4}\-\d{2}\-\d{2}/, :message => "^Date must be in the following format: mm/dd/yyyy"


  def validate_dates 
    if date_is_blank?
      return true
    elsif Date.today > start_date.to_date
      errors.add(:start_date, "Invalid check in date")

    elsif Date.today + 6.months < last_date.to_date 
      errors.add(:last_date, "Check out date should be within 6 months")
   
    elsif last_date.to_date < start_date.to_date
      errors.add(:last_date, "Invalid check out")
    end
  end

	# get the all the room_id which room are booked in between start_date and last_date
  def self.excluded_id(start_date,last_date)
    if (b= Booking.where("Date(start_date) < ? AND Date(last_date) > ? ", last_date,start_date).collect(&:room_id)).empty?
      return false
    else
      return b
    end
  end

  def check_room_availability
    if date_is_blank?
      return true
  	elsif (rooms = Room.avail_rooms(start_date, last_date, room_type).limit(1)).length > 0
  		room_id = rooms.first.id
		else
			errors.add("Rooms are not available #{room_type}")
		end
  end

  def date_is_blank?
    if start_date.blank? || last_date.blank?
      return true
    end
  end

  def room_type_int
    self.class.room_types[self.room_type]
  end
end
