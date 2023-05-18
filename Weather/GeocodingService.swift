//
//  GeocodingService.swift
//  Weather
//
//  Created by Walter Smith on 5/16/23.
//
//consumes geocoding api
// http://api.openweathermap.org/geo/1.0/direct?q={city name},{state code},{country code}&limit={limit}&appid={API key}

import Foundation

protocol GeocodingServiceDelegate {
    func weatherCityDidChange(_ service:GeocodingService) -> Void
}

class GeocodingService {
    var weatherCity = WeatherCity()
    var delegate : GeocodingServiceDelegate?
    
    func getCity(city:String,state:String,limit:Int=10) {
        guard let url = URL(string:"http://api.openweathermap.org/geo/1.0/direct?q=\(city),\(state)&limit=\(limit)&appid=\(api_key)") else {return}
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, response, error in
            if let data = data {
                do {
                    let cityNames = try JSONDecoder().decode([CityName].self, from:data)
                    self?.weatherCity.city = cityNames[0]
                    DispatchQueue.main.async {self?.delegate?.weatherCityDidChange(self!)}
                } catch {}
            } else {
                
            }
        }
        task.resume()
    }
    func getCity(city:String,limit:Int=10) {
        guard let url = URL(string:"http://api.openweathermap.org/geo/1.0/direct?q=\(city)&limit=\(limit)&appid=\(api_key)") else {return}
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, response, error in

            if let data = data {
                do {
                    let cityNames = try JSONDecoder().decode([CityName].self, from:data)
                    self?.weatherCity.city = cityNames[0]
                    DispatchQueue.main.async {self?.delegate?.weatherCityDidChange(self!)}
                } catch {}
            } else {
                
            }
        }
        task.resume()
    }
    func getCity(_ lat:Double,_ lon:Double, limit:Int = 10) {
        guard let url = URL(string:"https://api.openweathermap.org/geo/1.0/reverse?lat=\(lat)&lon=\(lon)&limit=\(limit)&appid=\(api_key)") else {return}
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, response, error in
            if let data = data {
                do {
                    let cityNames = try JSONDecoder().decode([CityName].self, from:data)
                    self?.weatherCity.city = cityNames[0]
                    DispatchQueue.main.async {self?.delegate?.weatherCityDidChange(self!)}
                } catch {print(error)}
            } else {
                print ("name lookup error")
            }
        }
        task.resume()
    }
    func getCity(zip:Double) {
        guard let url = URL(string:"https://api.openweathermap.org/geo/1.0/reverse?zip=\(zip),US&appid=\(api_key)") else {return}
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, response, error in
            if let data = data {
                do {
                    let city = try JSONDecoder().decode(CityName.self, from:data)
                    self?.weatherCity.city = city
                    DispatchQueue.main.async {self?.delegate?.weatherCityDidChange(self!)}
                } catch {}
            } else {
                
            }
        }
        task.resume()
    }
}
