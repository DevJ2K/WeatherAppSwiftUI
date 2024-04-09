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
        HStack(alignment: .center) {
            Spacer()
            VStack(spacing: 10) {
                
                HStack(spacing: 4) {
                    Image(systemName: "wind")
                        .font(.system(size: 14))
                    Text("Wind")
                        .font(.system(size: 13, weight: .light))
                }
//                .background(.blue)
                if (wind_speed != nil) {
                    Text("\(String(format: "%.1f", (wind_speed!)))km/h")
                        .font(.system(size: 14, weight: .semibold, design: .rounded))
                } else {
                    Text("???")
                        .font(.system(size: 14, weight: .semibold, design: .rounded))
                        .opacity(0.4)
                }
            }
            .frame(maxWidth: .infinity)
            
            Divider()
                .background(.white.opacity(0.8))
                .padding(.vertical)
            VStack(spacing: 6) {
                
                HStack(spacing: 4) {
                    Image(systemName: "humidity")
                        .font(.system(size: 12))
                    Text("Humidity")
                        .font(.system(size: 12))
                        .opacity(0.8)
                }
//                .background(.blue)
                if (humidity != nil) {
                    Text("\(humidity!)%")
                        .font(.system(size: 14, weight: .bold))
                } else {
                    Text("???")
                }
            }
            .frame(maxWidth: .infinity)
//            .background(.red)
//           Spacer()
            Divider()
                .background(.white.opacity(0.8))
                .padding(.vertical)
            VStack(spacing: 6) {
                HStack(spacing: 4) {
                    Image(systemName: "cloud.rain")
                        .font(.system(size: 12))
                    Text("Rain")
                        .font(.system(size: 12))
                        .opacity(0.8)
                }
//                .background(.blue)
                if (precipitation_probability != nil) {
                    Text("\(precipitation_probability!)%")
                        .font(.system(size: 14, weight: .bold))
                } else {
                    Text("???")
                }
            }
            .frame(maxWidth: .infinity)
//            .background(.red)
            Spacer()
        }
        .frame(height: 90)
        .background(.black.opacity(0.15))
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .padding()
    }
}

#Preview {
    return ContentView()
    VStack {
        CurrentInfoDash(wind_speed: 18.9, humidity: 43, precipitation_probability: 74)
        CurrentInfoDash()
    }
    .preferredColorScheme(.dark)
    .background(LinearGradient(colors: [Color.indigo.opacity(0.2), Color.indigo.opacity(0.6)], startPoint: .top, endPoint: .bottom))
}
