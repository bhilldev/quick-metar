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
    @State private var searchText = ""
    @State private var isEditing = false
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
        
        GeometryReader { geometry in
            VStack {
                VStack(alignment: .leading) {
                    TextField("Search ...", text: $Icao)
                        .padding(7)
                        .padding(.horizontal, 25)
                        .background(Color(red: 0.229, green: 0.54, blue: 0.726))
                        .cornerRadius(8)
                        .textCase(.uppercase)
                        .padding(.horizontal, 10)
                        .onTapGesture {
                            self.isEditing = true
                        }
                        
                    Spacer()
                }
                VStack(alignment: .leading){
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
                    .foregroundColor(Color(red: 216 / 255, green: 210 / 255, blue: 203 / 255))
                    Spacer()
                }.padding()
                    .frame(height: geometry.size.height * 0.8)
                    
            }
            
            .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(red: 0.117, green: 0.402, blue: 0.551)/*@END_MENU_TOKEN@*/)
            .foregroundColor(Color(red: 238 / 255, green: 238 / 255, blue: 238 / 255))
            
        }
        
    }
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView(Icao: "", cloudString: "")
        }
    }
}
