//
//  CurrentInfoDash.swift
//  weatherfinal_proj
//
//  Created by Théo Ajavon on 08/04/2024.
//

import SwiftUI

struct CurrentInfoDash: View {
    var wind_speed: Double?
    var humidity: Int8?
    var precipitation_probability: Int8?
    
    var body: some View {
        HStack {
            VStack(spacing: 14) {
                Image(systemName: "wind")
                if (wind_speed != nil) {
                    Text("\(String(format: "%.1f", (wind_speed!)))km/h")
                } else {
                    Text("???")
                }
                Text("Wind")
                    .opacity(0.8)
            }
            .padding()
//            .background(.red)
//           Spacer()
            VStack(spacing: 14) {
                Image(systemName: "humidity")
                if (humidity != nil) {
                    Text("\(humidity!)%")
                } else {
                    Text("???")
                }
                Text("Humidity")
                    .opacity(0.8)
            }
            .padding()
//            .background(.red)
//           Spacer()
            VStack(spacing: 14) {
                Image(systemName: "cloud.rain")
                if (precipitation_probability != nil) {
                    Text("\(precipitation_probability!)%")
                } else {
                    Text("???")
                }
                Text("Rain")
                    .opacity(0.8)
            }
            .padding()
            .frame(width: 100)
//            .background(.red)
        }
//        .frame(width: nil)
        .background(.ultraThinMaterial.opacity(0.6))
//        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: Color.black.opacity(0.1), radius: 6, x: 2, y: 4)
        .padding()
    }
}

#Preview {
    VStack {
        CurrentInfoDash(wind_speed: 18.9, humidity: 43, precipitation_probability: 74)
        CurrentInfoDash()
    }
    .background(LinearGradient(colors: [Color.indigo.opacity(0.2), Color.indigo.opacity(0.6)], startPoint: .top, endPoint: .bottom))
}
