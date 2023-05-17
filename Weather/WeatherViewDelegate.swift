//
//  WeatherViewDelegate.swift
//  Weather
//
//  Created by Walter Smith on 5/16/23.
//

import Foundation
import UIKit

class WeatherViewDelegate: ObservableObject, LocationServiceDelegate,WeatherServiceDelegate,IconServiceDelegate{

   
    @Published var cityName:String
    @Published var weatherIcon: UIImage
    @Published var weatherDetails:String
    var weatherCity : WeatherCity?
    var weatherService: WeatherService = WeatherService()
    var locationService: LocationService?
    var iconService = IconService()
    
    init() {
        cityName = ""
        weatherIcon = UIImage(systemName: "star")!
        weatherDetails=""
        iconService.delegate = self
        weatherService.delegate = self
        updateWeather()
    }
    func iconDidFinishLoad(_ service: IconService) {
        let userDefaults = UserDefaults()
        self.weatherIcon = service.image ?? UIImage()
        userDefaults.set(weatherCity, forKey: "weatherCity")
        print("icon did finish load")
    }
    func weatherDidChange(_ service: WeatherService) {
        let userDefaults = UserDefaults()
        self.weatherCity = service.weatherCity
        guard case self.cityName = self.weatherCity?.city?.name else {return}
        guard case self.weatherDetails = self.weatherCity?.weather?.weather[0].description else {return}
        if let icon = self.weatherCity?.weather?.weather[0].icon {
            self.iconService.fetch(code:icon)
        }
        userDefaults.set(weatherCity, forKey: "weatherCity")
        print("weather did change")
    }
    func locationDidChange(_ location: LocationService) {
        print("location did change")
        let userDefaults = UserDefaults()
        self.weatherCity = location.weatherCity
        self.cityName = self.weatherCity?.city?.name ?? "drat"
        guard case self.weatherDetails = self.weatherCity?.weather?.weather[0].description else {
            print("failed")
            return}
        if let icon = self.weatherCity?.weather?.weather[0].icon {
            print("fetching icon")
            self.iconService.fetch(code:icon)
        }
        userDefaults.set(weatherCity, forKey: "weatherCity")
    }
    func updateWeather() {
        let userDefaults = UserDefaults()
        weatherCity = userDefaults.object(forKey: "weatherCity") as! WeatherCity?
        if let weatherCity = weatherCity {
            weatherService.getWeather(lat:weatherCity.weather?.coord.lat ?? 0.0, lon:weatherCity.weather?.coord.lon ?? 0.0)
        } else {
            if let locationService = locationService {
            } else {
                let locationService = LocationService()
                locationService.delegate = self
                locationService.checkLocationPermission()
            }
        }
        userDefaults.set(weatherCity, forKey: "weatherCity")
        
        guard let weatherDetails = weatherCity?.weather?.weather.description else {return}
    }
    func getWeather(query:String) {
        let cityAndState = /([\w\s]+)\s*,\s*([\w\s]+)/
        let city = /([\w ]*)/
        let cityCoords = /([\d\.]*)\s*,\s*([\d\.]*)/
        
        if let match = query.firstMatch(of: cityCoords) {
            weatherService.getWeather(lat:Double(String(match.1)) ?? 0.0, lon:Double(String(match.2)) ?? 0.0)
        } else
        if let match = query.firstMatch(of: cityAndState) {
            weatherService.getWeather(city:String(match.1),state:String(match.2))
        } else
        if let match = query.firstMatch(of: city) {
            weatherService.getWeather(city:String(match.1))
        }
    }
}
