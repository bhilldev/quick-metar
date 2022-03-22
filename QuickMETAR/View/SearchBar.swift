//
//  SearchBar.swift
//  QuickMETAR
//
//  Created by Brandon Hill on 3/7/22.
//

import SwiftUI

struct SearchBar: View{
    
    @Binding var icao: String
    @Binding var showMetar: Bool
    
    @ObservedObject var viewModel: API
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Button(action: {
                    viewModel.getData(icao: icao)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        showMetar = true
                    }
                    
                }, label: {
                    Image(systemName: "magnifyingglass")
                }).padding(2)
                TextField("Search by ICAO... (eg. KJFK)", text: $icao)
                    .textInputAutocapitalization(.characters)
            }
            .padding(7)
            .background(Color(red: 0.229, green: 0.54, blue: 0.726))
            .cornerRadius(8)
            .padding(.horizontal, 10)
            
            Spacer()
        }
        
    }
    
}
