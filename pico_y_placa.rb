class PicoYPlaca
  require 'time'
  require 'date'

  # times during 'pico y placa' is active
  RESTRICTED_HOURS = [
                      [Time.parse('7:30'),  Time.parse('9:30')],
                      [Time.parse('16:00'), Time.parse('19:30')]
                     ]

  # day_of_the_week => plate number authorize
  REPARTITION = {
                  'Monday'    => %w(1 2),
                  'Tuesday'   => %w(3 4),
                  'Wednesday' => %w(5 6),
                  'Thursday'  => %w(7 8),
                  'Friday'    => %w(9 0),
                  'Saturday'  => %w(1 2 3 4 5 6 7 8 9 0),
                  'Sunday'    => %w(1 2 3 4 5 6 7 8 9 0)
                }

  # errors
  class InvalidDateError < StandardError; end
  class InvalidTimeError < StandardError; end
  class InvalidPlateError < StandardError; end

  # regex for validation
  REGEX_TIME  = /\A([01]?[0-9]|2[0-3]):[0-5][0-9]\z/
  REGEX_PLATE = /\A[A-Z]{3}-[0-9]{3,4}\z/

  attr_reader :day, :time, :last_digit_plate_number

  def initialize(args)
    @last_digit_plate_number = parse_plate_number(args.fetch(:plate_number, ''))
    @day                     = parse_date(args.fetch(:date, ''))
    @time                    = parse_time(args.fetch(:time, ''))
  end

  def can_ride?
    is_in_restricted_hours?(time) ? REPARTITION[day].include?(last_digit_plate_number) : true
  end

  private

  def is_in_restricted_hours?(time)
    RESTRICTED_HOURS.any? { |interval| time.between?(interval[0], interval[1]) }
  end

  def self.valid_date?(str, format="%d/%m/%Y")
    Date.strptime(str,format) rescue false
  end

  # parsers
  def parse_plate_number(plate_number)
    raise InvalidPlateError unless REGEX_PLATE.match(plate_number)
    plate_number[-1, 1]
  end

  def parse_date(date)
    raise InvalidDateError unless self.class.valid_date?(date)
    Date.parse(date).strftime('%A')
  end

  def parse_time(time)
    raise InvalidTimeError unless REGEX_TIME.match(time)
    Time.parse(time)
  end
end
