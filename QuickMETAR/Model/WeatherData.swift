//
//  WeatherData.swift
//  QuickMETAR
//
//  Created by Brandon Hill on 2/23/22.
//

import Foundation
//Wind x, Clouds x, Temperature x, Dew Point, Altimiter x
struct WeatherData: Codable {
    var altimeter: Altimeter
//    var wind_direction: WindDirection
    var station: String
//    var flight_rules: String
    var dewpoint: DewPoint
    var temperature: Temperature
    var visibility: Visibility
    var clouds: [Clouds]
    var wind_speed: WindSpeed
    var wind_direction: WindDirection
}

struct Altimeter: Codable {
    var value: Double
}

struct WindDirection: Codable {
    var value: Double
}

struct WindSpeed: Codable {
    var repr: String
}

struct Temperature: Codable {
    var value: Int
}

struct Clouds: Codable  {
    var repr: String
}
struct DewPoint: Codable {
    var value: Int
}
struct Visibility: Codable {
    var value: Int
}
