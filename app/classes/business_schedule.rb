class BusinessSchedule
  attr_accessor :day_id, :time_close, :time_open

  def initialize(day_id, time_open, time_close)
    @day_id = day_id
    @time_close = time_close
    @time_open = time_open
  end

  def day
    case @day_id
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
    Time.at(@time_open).utc.strftime("%I:%M%p")
  end

  def display_close_time
    Time.at(@time_close).utc.strftime("%I:%M%p")
  end

  def open_hours
    "#{display_open_time} - #{display_close_time}".downcase
  end


end