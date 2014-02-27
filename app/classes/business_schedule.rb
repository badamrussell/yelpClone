class BusinessSchedule
  attr_accessor :day_id, :time_close, :time_open

  def initialize
    @days = Array.new(7)
  end

  def add(day_id, time_open, time_close)
    @days[day_id] = (time_open.hours..time_close.hours)
  end

  def [](day_id)
    @days[day_id]
  end

  def day(day_id)
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

  def display_open_time(day_id)
    Time.at(@days[day_id].first).utc.strftime("%I:%M%p")
  end

  def display_close_time(day_id)
    Time.at(@days[day_id].last).utc.strftime("%I:%M%p")
  end

  def open_hours(day_id)
    if @days[day_id]
      "#{display_open_time(day_id)} - #{display_close_time(day_id)}".downcase
    else
      ""
    end
  end

  def is_open?(day_id)
    time_now = Time.now.hour.hours + Time.now.min.minutes
    @days[day_id] && @days[day_id] === time_now
  end

end