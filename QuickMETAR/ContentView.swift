//
//  ContentView.swift
//  QuickMETAR
//
//  Created by Brandon Hill on 2/22/22.
//

import SwiftUI


struct ContentView: View {
    
    let fontSize: CGFloat = 22
    
    @State var data = WeatherData(
        altimeter: Altimeter(value: 0.0),
        station: "KMCI" ,
        dewpoint: DewPoint(value: 0),
        temperature: Temperature(value: 0),
        visibility: Visibility(value: 0),
        clouds: [Clouds(repr: "")]
    )
    //@State var Icao: String
    @State var Icao: String
    @State var cloudString: String
    
    func getData() {
        let urlString = "https://avwx.rest/api/metar/\(Icao)?token=zc12yYWWj7T7z2FP6GVRKmbFtyhfrwL3-Mb_TLyfS98"
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
        
        //Order note: Wind, Clouds, Temperature, Dew Point, Altimiter
        VStack(alignment: .leading) {
            TextField(/*@START_MENU_TOKEN@*/"Placeholder"/*@END_MENU_TOKEN@*/, text: $Icao)
            Text("Station: \(Icao)")
                .font(.system(size: fontSize))
            Text("Visibility: \(data.visibility.value) sm")
                .font(.system(size: fontSize))
            HStack {
                //If no cloud layers are present
                if data.clouds.count == 0 {
                    Text("Clouds: None")
                        .font(.system(size: fontSize))
                //If one or more cloud layers are present
                } else {
                    ForEach(0..<data.clouds.count, id: \.self) { i in
                        if i == 0 {
                            Text("Clouds: ")
                                .font(.system(size: fontSize))
                            Text(data.clouds[0].repr)
                        } else {
                            Text(data.clouds[i].repr)
                        }
                    }
                }
            }
            Text("Temperature: \(data.temperature.value) &deg;C")
                .font(.system(size: fontSize))
            Text("Dew Point: \(data.dewpoint.value) &deg;C")
                .font(.system(size: fontSize))
            Text("Altimeter: \(altimeterRounded)inHg")
                .font(.system(size: fontSize))
        
            Button("Refresh data") {self.getData()}
        
        }.padding()
    }
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView(Icao: "KLWC", cloudString: "")
        }
    }
}
