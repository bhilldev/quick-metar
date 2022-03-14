//
//  ContentView.swift
//  QuickMETAR
//
//  Created by Brandon Hill on 2/22/22.
//

import SwiftUI


struct ContentView: View {
    
    @State var icao: String
    //@State var showView: Bool = false
    @ObservedObject var viewModel = API()
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                SearchBar(icao: $icao, viewModel: viewModel)
                    
                MetarView(icao: $icao, viewModel: viewModel)
                 .frame(height: geometry.size.height * 0.90)
                
            }
            .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(red: 0.117, green: 0.402, blue: 0.551)/*@END_MENU_TOKEN@*/)
            .foregroundColor(Color(red: 238 / 255, green: 238 / 255, blue: 238 / 255))
        }
    }
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView(icao: "")
        }
    }
}
