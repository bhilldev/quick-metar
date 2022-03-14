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
        
        let altimeterRounded = String(format: "%.2f", viewModel.data.altimeter.value)
        
        VStack(alignment: .leading){
            Text("Station: \(icao)")
                .font(.system(size: fontSize))
            Text("Visibility: \(viewModel.data.visibility.value) sm")
                .font(.system(size: fontSize))
            HStack {
                //If no cloud layers are present
                if viewModel.data.clouds.count == 0 {
                    Text("Clear Skies")
                        .font(.system(size: fontSize))
                //If one or more cloud layers are present
                } else {
                    ForEach(0..<viewModel.data.clouds.count, id: \.self) { i in
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
            Text("Altimeter: \(altimeterRounded)inHg")
                .font(.system(size: fontSize))
            Spacer()
        }.padding()
    }
    
}
