//
//  ContentView.swift
//  QuickMETAR
//
//  Created by Brandon Hill on 2/22/22.
//

import SwiftUI


struct ContentView: View {
    
    @State var data = WeatherData(
        altimeter: Altimeter(value: 0.0),
//        wind_direction: WindDirection(value: 0),
        station: "KMCI" ,
//        flight_rules: "",
        dewpoint: DewPoint(value: 0),
        temperature: Temperature(value: 0),
        visibility: Visibility(value: 0),
        clouds: [Clouds(repr: ""), Clouds(repr: "")]
    )
    
    let fontSize: CGFloat = 22
    
    func getData() {
        let urlString = "https://avwx.rest/api/metar/KMCI?token=zc12yYWWj7T7z2FP6GVRKmbFtyhfrwL3-Mb_TLyfS98"
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
   
    var body: some View {
        let altimeterRounded = String(format: "%.2f", data.altimeter.value)
        //Wind, Clouds, Temperature, Dew Point, Altimiter
        VStack(alignment: .leading) {
//            HStack {
//                Image(systemName: "magnifyingglass")
//                TextField("Search...", text: $icao)
//            }.textFieldStyle(RoundedBorderTextFieldStyle())
            Text("Station: \(data.station)")
                .font(.system(size: fontSize))
//            Text("Flight Rules: \(data.flight_rules)")
//                .font(.system(size: fontSize))
            Text("Visibility: \(data.visibility.value) sm")
                .font(.system(size: fontSize))
            Text("Clouds: \(data.clouds[0].repr) , \(data.clouds[1].repr)")
                .font(.system(size: fontSize))
            Text("Temperature: \(data.temperature.value) &deg;C")
                .font(.system(size: fontSize))
            Text("Dew Point: \(data.dewpoint.value) &deg;C")
                .font(.system(size: fontSize))
            Text("Altimeter: \(altimeterRounded)inHg")
                .font(.system(size: fontSize))
            
            
            Button("Refresh data") {self.getData()}
        }.padding()
        
    
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
