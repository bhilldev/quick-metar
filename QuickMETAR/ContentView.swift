//
//  ContentView.swift
//  QuickMETAR
//
//  Created by Brandon Hill on 2/22/22.
//

import SwiftUI


struct ContentView: View {
    //If the search button hasn't been pressed, or the icao size is not 4
    @State var icao: String
    //@State var showView: Bool = false
    @ObservedObject var viewModel = API()
    
    @State var showMetar: Bool = false
    
    var body: some View {
        
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                //altimeter, station, dewpoint, temperature, visibility, clouds, wind_speed, wind_direction
                
                SearchBar(icao: $icao, showMetar: $showMetar, viewModel: viewModel )
                    .onChange(of: icao) { newValue in
                        showMetar = false
                        viewModel.data.altimeter.value = 0.0
                        viewModel.data.station = ""
                        viewModel.data.dewpoint.value = 0
                        viewModel.data.temperature.value = 0
                        viewModel.data.visibility.value = 0
                        viewModel.data.clouds.removeAll()
                        viewModel.data.wind_speed.repr = ""
                        viewModel.data.wind_direction.value = 0
                        
                    }
                if showMetar {
                    
                    MetarView(icao: $icao, viewModel: viewModel)
                        .frame(height: geometry.size.height * 0.90)
                    
                }
               
                
            }
            .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(red: 0.117, green: 0.402, blue: 0.551)/*@END_MENU_TOKEN@*/)
            .foregroundColor(Color(red: 238 / 255, green: 238 / 255, blue: 238 / 255))
            
        }
    }
//        struct ContentView_Previews: PreviewProvider {
//            static var previews: some View {
//                ContentView(icao: "", showMetar: false)
//            }
//        }
}



