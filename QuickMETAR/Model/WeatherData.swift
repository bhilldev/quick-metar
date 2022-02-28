//
//  WeatherData.swift
//  QuickMETAR
//
//  Created by Brandon Hill on 2/23/22.
//

import Foundation
//Wind x, Clouds x, Temperature x, Dew Point, Altimiter x
struct WeatherData: Decodable {
    var altimeter: Altimeter
//    var wind_direction: WindDirection
    var station: String
//    var flight_rules: String
    var dewpoint: DewPoint
    var temperature: Temperature
    var visibility: Visibility
    var clouds: [Clouds]
}

struct Altimeter: Codable {
    var value: Double
}

struct WindDirection: Decodable {
    var value: Int
}

struct Temperature: Decodable {
    var value: Int
}

struct Clouds: Decodable  {
    var repr: String
}
struct DewPoint: Decodable {
    var value: Int
}
struct Visibility: Decodable {
    var value: Int
}
