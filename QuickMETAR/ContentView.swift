//
//  ContentView.swift
//  QuickMETAR
//
//  Created by Brandon Hill on 2/22/22.
//

import SwiftUI


struct ContentView: View {
    @State var data = WeatherData(station: "No airport yet" , flight_rules: "No flight rules yet")
    
    let fontSize: CGFloat = 32
    
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
        VStack {
            Button("Refresh data") {self.getData()}
            Text("\(data.station)")
                .font(.system(size: fontSize))
            Text("\(data.flight_rules)")
                .font(.system(size: fontSize))
            
        }
        
    }
}
