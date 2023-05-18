//
//  WeatherViewDelegate.swift
//  Weather
//
//  Created by Walter Smith on 5/16/23.
//
// This is the VM. I am typing everything together with delegates.

import Foundation
import UIKit

class WeatherViewDelegate: ObservableObject, LocationServiceDelegate,WeatherServiceDelegate,IconServiceDelegate{

    // weather information for shipping to the view
    @Published var cityName:String
    @Published var weatherIcon: UIImage
    @Published var weatherDetails:String
    
    // vars
    var weatherCity : WeatherCity = WeatherCity()
    var weatherService: WeatherService = WeatherService()
    var locationService: LocationService?
    var iconService = IconService()
    
    // giving the vars dummy values
    init() {
        cityName = "User City"
        weatherIcon = UIImage(systemName: "star")!
        weatherDetails="weather details"
        iconService.delegate = self
        weatherService.delegate = self
        updateWeather()
    }
    
    // delegate, updates icon
    func iconDidFinishLoad(_ service: IconService) {
        self.weatherIcon = service.image ?? UIImage()
    }
    
    // saves current city to so it will show up when the app is next loaded
    func saveCity() {
        let userDefaults = UserDefaults()
        if let lat = self.weatherCity.city?.lat{
            if let lon = self.weatherCity.city?.lon {
                userDefaults.set([lat,lon], forKey: "weatherCity")
            }
        }
    }
    
    //loads previous city when app loads
    func loadCity() -> Bool{
        let userDefaults = UserDefaults()
        if let location = userDefaults.array(forKey: "weatherCity") {
            let lat:Double = location[0] as! Double
            let lon:Double = location[1] as! Double
            weatherService.getWeather(lat:lat, lon:lon)
            return true
        }
        return false
    }
    // delegate from weather model. triggered when weather api is loaded
    func weatherDidChange(_ service: WeatherService) {
        self.weatherCity = service.weatherCity
        guard case self.cityName = self.weatherCity.city?.name else {return}
        guard case self.weatherDetails = self.weatherCity.weather?.weather[0].description else {return}
        if let icon = self.weatherCity.weather?.weather[0].icon {
            self.iconService.fetch(code:icon)
        }
        saveCity()
        
    }
    
    // delegate from location model
    func locationDidChange(_ location: LocationService) {
        self.weatherCity = location.weatherCity
        self.cityName = self.weatherCity.city?.name ?? "User City"
        // TODO: figure out how this is always true
        if case let weatherDetails = self.weatherCity.weather?.weather[0].description {
            self.weatherDetails = weatherDetails ?? ""
        }
        else {
            print("location failed")
            return}
        if let icon = self.weatherCity.weather?.weather[0].icon {
            self.iconService.fetch(code:icon)
        } else {
        }
        saveCity()
    }
    // should be called, "init weather" loads initial weather from location or previous city.
    func updateWeather() {
        if loadCity() {
            return
        }
        if let locationService = locationService {
            
            } else {
                let locationService = LocationService()
                locationService.delegate = self
                locationService.checkLocationPermission()
        }
    }
    
    // parses the query string and searches for weather.
    func getWeather(query:String) {
        
        //I just love regex, don't you?
        let cityAndState = /([\w\s]+)\s*,\s*([\w\s]+)/
        let city = /([\w ]*)/
        let cityCoords = /([\d\.]*)\s*,\s*([\d\.]*)/
        let zipCoords = /\s*(\d*)\s*/
        
        if let match = query.firstMatch(of: cityCoords) {
            weatherService.getWeather(lat:Double(String(match.1)) ?? 0.0, lon:Double(String(match.2)) ?? 0.0)
        } else
        if let match = query.firstMatch(of: cityAndState) {
            weatherService.getWeather(city:String(match.1),state:String(match.2))
        } else
        if let match = query.firstMatch(of: city) {
            weatherService.getWeather(city:String(match.1))
        } else
        if let match = query.firstMatch(of: city) {
            weatherService.getWeather(zip:Double(String(match.1)) ?? 0.0)
        }
    }
}
