require 'httparty'
require 'pp'
require 'json'
require 'colorize'

class WeatherForecast 
  include HTTParty

  API_KEY= ENV['API_KEY']
  #using json

  attr_accessor :location, :number_days
  def initialize(location='Calgary',number_days='5')
    @location=location
    @number_days=number_days
  end

  def request()
  	request_uri= "http://api.openweathermap.org/data/2.5/forecast/daily?q=#{location}&mode=json&units=metric&cnt=#{number_days}&appid=#{API_KEY}"
  	@response=HTTParty.get(request_uri)
  end

  def temps
    high_temps=[]
    low_temps=[]
    @response['list'].each do |day|
      high_temps<< day['temp']['max']
      low_temps<< day['temp']['min']
    end
    puts "The high temp and low temp for today are #{high_temps[0]}, #{low_temps[0]} degrees celcius respectively".blue
    puts "The high temp and low temp for tomorrow are #{high_temps[1]}, #{low_temps[1]} degrees celcius respectively".green

  end
end


forecast=WeatherForecast.new
forecast.request
forecast.temps