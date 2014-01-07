class BusinessHour < ActiveRecord::Base
    attr_accessible :business_id, :day_id, :time_close, :time_open

  validates :business_id, :day_id, :time_close, :time_open, presence: true

  belongs_to(
  	:business,
  	class_name: "Business",
  	primary_key: :id,
  	foreign_key: :business_id
  )

  def day
  	case day_id
  	when 0
  		"Sun"
  	when 1
  		"Mon"
  	when 2
  		"Tue"
  	when 3
  		"Wed"
  	when 4
  		"Thu"
  	when 5
  		"Fri"
  	when 6
  		"Sat"
  	else
  		"???"
  	end
  end

  def display_open_time
  	Time.at(time_open).utc.strftime("%I:%M%p")
  end

  def display_close_time
  	Time.at(time_close).utc.strftime("%I:%M%p")
  end

  def open_hours
  	"#{display_open_time} - #{display_close_time}".downcase
  end
end
