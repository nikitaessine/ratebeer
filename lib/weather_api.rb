class WeatherApi
    def self.weather_in(city)
        city = city.downcase
        Rails.cache.fetch("#{city}_weather", expires_in: 1.week) { get_weather_in(city) }
    end
    
    def self.get_weather_in(city)
        url = "http://api.weatherstack.com/current?access_key=#{key}&query="
        response = HTTParty.get "#{url}#{ERB::Util.url_encode(city)}"
        response.parsed_response["current"]
    end
  
    def self.key
      return nil if Rails.env.test? # no API needed when testing, return nil
      raise 'WEATHER_APIKEY env variable not defined' if ENV['WEATHER_APIKEY'].nil?
      ENV.fetch('WEATHER_APIKEY')
    end
end