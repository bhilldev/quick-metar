//
//  Api.swift
//  QuickMETAR
//
//  Created by Brandon Hill on 3/7/22.
//

import Foundation
import SwiftUI

class API : ObservableObject {
    
    @Published var data = WeatherData(
        altimeter: Altimeter(value: 0),
        station: "KMCI",
        dewpoint: DewPoint(value: 0),
        temperature: Temperature(value: 0),
        visibility: Visibility(value: 0),
        clouds: [Clouds(repr: "")],
        wind_speed: WindSpeed(repr: "", value: 0.0),
        wind_direction: WindDirection(repr: "", value: 0.0)
    )
    
    func getData(icao: String) {

        let urlString = "https://avwx.rest/api/metar/\(icao)?token=zc12yYWWj7T7z2FP6GVRKmbFtyhfrwL3-Mb_TLyfS98"
        
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) { data, _, error in
            DispatchQueue.main.async {
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let decodedData = try decoder.decode(WeatherData.self, from: data)
                        self.data = decodedData
                        
                    }catch {
                        print("Error! Something went wrong")
                    }
                }
            }
        }.resume()
        
    }
}
