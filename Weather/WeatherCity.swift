//
//  WeatherCity.swift
//  Weather
//
//  Created by Walter Smith on 5/16/23.
//

import Foundation
struct Coord : Decodable {
    let lon:Double
    let lat:Double
}
struct Main : Decodable {
    let temp:Double
}
struct Weather : Decodable {
    //let id : Int
    let description:String
    let icon : String
}
class CityWeather : Decodable, Equatable
{
    static func == (lhs: CityWeather, rhs: CityWeather) -> Bool {
        return lhs.coord.lat == rhs.coord.lat && lhs.coord.lon == rhs.coord.lon
    }
    let coord: Coord
    let weather: [Weather]
    let main: Main
}
class CityName : Decodable, Equatable {
    static func == (lhs: CityName, rhs: CityName) -> Bool {
        return lhs.lat == rhs.lat && lhs.lon == rhs.lon
    }
    let name: String
    let country: String
    let state: String
    let lat: Double
    let lon: Double
}
class WeatherCity {
    var city: CityName?
    var weather: CityWeather?
}
