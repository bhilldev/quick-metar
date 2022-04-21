//
//  MetarView.swift
//  QuickMETAR
//
//  Created by Brandon Hill on 3/7/22.
//

import SwiftUI

struct MetarView: View {
    
    let fontSize: CGFloat = 22
    @Binding var icao: String
    @ObservedObject var viewModel: API
    var body: some View {
        
        let windDirectionString = String(format: "%.0f", viewModel.data.wind_direction.value)
        let normalAltimeter = String(format: "%.0f", viewModel.data.altimeter.value)
        
        VStack(alignment: .leading){
            Text("Station: \(icao)")
                .font(.system(size: fontSize))
            
            // Visibility different outside US and Canada
            if icao.starts(with: "K") || icao.starts(with: "P") || icao.starts(with: "C") {
                Text("Visibility: \(viewModel.data.visibility.value) sm")
                    .font(.system(size: fontSize))
            } else {
                if viewModel.data.visibility.value == 9999 {
                    Text("Visibility: 10km or more")
                        .font(.system(size: fontSize))
                } else {
                    Text("Visibility: \(viewModel.data.visibility.value) m")
                        .font(.system(size: fontSize))
                }
            }
            HStack {
                //If no cloud layers are present
                if viewModel.data.clouds.count == 0 {
                    Text("No clouds")
                        .font(.system(size: fontSize))
                    //If one or more cloud layers are present
                } else {
                    ForEach(0..<viewModel.data.clouds.count, id: \.self) { i in
                        // Put "Clouds: ..." on the first layer
                        if i == 0 {
                            Text("Clouds: ")
                                .font(.system(size: fontSize))
                            Text(viewModel.data.clouds[0].repr)
                        } else {
                            Text(viewModel.data.clouds[i].repr)
                        }
                    }
                }
            }
            Text("Temperature: \(viewModel.data.temperature.value) &deg;C")
                .font(.system(size: fontSize))
            Text("Dew Point: \(viewModel.data.dewpoint.value) &deg;C")
                .font(.system(size: fontSize))
            
            //Altimeter different outside US and Canada
            if icao.starts(with: "K") || icao.starts(with: "P") || icao.starts(with: "C"){
                Text("Altimeter: \(viewModel.data.altimeter.value, specifier: "%.2f") inHg")
                    .font(.system(size: fontSize))
            } else {
                Text("Altimeter: \(normalAltimeter) hPa")
                    .font(.system(size: fontSize))
            }
            if windDirectionString != "0" {
                Image(systemName: "arrow.up")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100, alignment: .center)
                    .rotationEffect(.degrees(viewModel.data.wind_direction.value - 180))
                Text("Wind: \(viewModel.data.wind_direction.value, specifier: "%.0f")&deg; at \(viewModel.data.wind_speed.repr) knots")
                    .font(.system(size: fontSize))
            } else {
                Text("Wind: Calm")
                    .font(.system(size: fontSize))
            }
            Spacer()
            
        }.padding()
    }
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView(icao: "", showMetar: false)
        }
    }
}
