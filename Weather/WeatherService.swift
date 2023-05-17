//
//  WeatherService.swift
//  Weather
//
//  Created by Walter Smith on 5/16/23.
//
//https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}
//http://api.openweathermap.org/data/2.5/weather?q=London,uk&APPID=368940b0edf5e826c673034af78735ec
//https://api.openweathermap.org/data/2.5/weather?id={city id}&appid={API key}

import Foundation

let api_key:String = "368940b0edf5e826c673034af78735ec"

protocol WeatherServiceDelegate {
    func weatherDidChange(_ service:WeatherService)->Void
}

class WeatherService: NSObject, GeocodingServiceDelegate {
    var weatherCity = WeatherCity()
    var delegate : WeatherServiceDelegate?
    let geocodingService = GeocodingService()
    
    func weatherCityDidChange(_ service: GeocodingService) {
        guard case self.weatherCity.city = service.weatherCity.city else {return}
        actuallyGetWeather(lat:weatherCity.city?.lat ?? 0.0, lon:weatherCity.city?.lon ?? 0.0)
    }
    
    func actuallyGetWeather(lat:Double, lon:Double) {
        print("actually get weather")
        dump(self.weatherCity)
        guard let url = URL(string:"https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&units=imperial&appid=\(api_key)") else {return}
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, response, error in
            if let data = data {
                do {
                    let cityWeather = try JSONDecoder().decode(CityWeather.self, from:data)
                    self?.weatherCity.weather = cityWeather
                    DispatchQueue.main.async {
                        self?.delegate?.weatherDidChange(self!)
                    }
                } catch {print(error)}
            } else {
                
            }
        }
        task.resume()
    }
    func getWeather (city:String) {
        geocodingService.getCity(city: city)
        
    }
    func getWeather (city:String,state:String) {
        geocodingService.getCity(city: city, state:state)
        
    }
    func getWeather(lat:Double, lon:Double) {
        dump(self.weatherCity)
        geocodingService.getCity(lat,lon)
    }
}
