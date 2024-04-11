//
//  WeeklyView.swift
//  weatherAppV2proj
//
//  Created by Théo Ajavon on 29/03/2024.
//

import SwiftUI

struct WeeklyView: View {
    var cityInfo: CityInfo?
    
    var body: some View {
        ScrollView {
            VStack {
                WeeklyChart(weekly: cityInfo?.daily)
                ScrollViewContent()
            }
        }
    }
    
    @ViewBuilder
    func ScrollViewContent() -> some View {
        ScrollView(.horizontal) {
            HStack(spacing: 0) {
                if (cityInfo?.daily != nil) {
                    ForEach(0 ..< min(7, cityInfo!.daily!.time.count), id: \.self) { i in
                        VStack(spacing: 12) {
                            if (i == 0) {
                                Text("Today")
                                    .font(.system(size: 14, weight: .semibold))
                            } else if (i == 1) {
                                Text("Tomorrow")
                                    .font(.system(size: 14, weight: .semibold))
                            } else {
                                Text("\(cityInfo!.daily!.time[i].split(separator: "-")[2])/\(cityInfo!.daily!.time[i].split(separator: "-")[1])")
                                    .font(.system(size: 14, weight: .semibold))
                                
                            }
//                            Text("\(getWeatherDescription(weather_code: cityInfo!.hourly!.weather_code[i])?.dayDescription ?? "")")
                            MiniSceneView(sceneName: "cloudy_night.scn")
                                .frame(height: 40)
                            VStack(spacing: 4) {
                                HStack(spacing: 4) {
//                                    Image(systemName: getTempLogo(temperature: cityInfo!.hourly!.temperature_2m[i]))
//                                        .font(.system(size: 14))
//                                        .opacity(0.8)
                                    Text("\(String(format: "%.1f", cityInfo!.daily!.temperature_2m_max[i]))°C max")
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundStyle(.orange)
                                }
                                HStack(spacing: 4) {
//                                    Image(systemName: "wind")
//                                        .font(.system(size: 14))
//                                        .opacity(0.8)
                                    Text("\(String(format: "%.1f", cityInfo!.daily!.temperature_2m_min[i]))°C min")
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundStyle(.blue)
                                }
                            }
                        }
                        .padding()
//                        .background(.blue.gradient)
                    }
                }
            }
        }
        .background(.black.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding(.horizontal)
    }
}

#Preview {
//    return ContentView()
    let jsonString = """
        {
            "city": {
                "id": 2988507,
                "name": "Paris",
                "latitude": 48.85341,
                "longitude": 2.3488,
                "elevation": 42,
                "timezone": "Europe/Paris",
                "country": "France",
                "admin1": "Île-de-France"
            },
            "current": {
                "time": "2024-04-04T11:30",
                "temperature_2m": 14.6,
                "is_day": 1,
                "weather_code": 80,
                "wind_speed_10m": 18.9
            },
            "hourly": {
                "time": ["2024-04-04T00:00", "2024-04-04T01:00", "2024-04-04T02:00", "2024-04-04T03:00", "2024-04-04T04:00", "2024-04-04T05:00", "2024-04-04T06:00", "2024-04-04T07:00", "2024-04-04T08:00", "2024-04-04T09:00",
                                  "2024-04-04T10:00", "2024-04-04T11:00", "2024-04-04T12:00", "2024-04-04T13:00", "2024-04-04T14:00",
                                  "2024-04-04T15:00", "2024-04-04T16:00", "2024-04-04T17:00", "2024-04-04T18:00", "2024-04-04T19:00",
                                  "2024-04-04T20:00", "2024-04-04T21:00", "2024-04-04T22:00", "2024-04-04T23:00",],
                "temperature_2m": [13.0, 7.8, 13.3, 13.2, 25, 26.7, 28.1, 29.5, 30.2, 31.8, 32.5, 32.9, 33.2, 33.5, 33.8, 33.9, 33.6, 33.2, 32.8, 32.5, 32.2,
                                                                                                                                    32.0, 31.8, 31.5, 31.2, 30.9, 30.6, 30.3, 30.0],
                "weather_code": [2, 61, 61, 61, 61, 61, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32],
                "wind_speed_10m": [18.2, 17.3, 18.7, 17.2, 19, 20.1, 21.5, 22.3, 23.6, 24.9, 25.3, 25.8, 26.2, 26.5, 26.7, 26.8, 26.6, 26.3, 26.0, 25.7, 25.4,
                                                                                                                                                                                                                                                                                                                                         25.1, 24.8, 24.5, 24.2, 23.9, 23.6, 23.3, 23.0]
            },
            "daily": {
                "time": ["2024-04-04", "2024-04-05", "2024-04-06", "2024-04-07", "2024-04-08", "2024-04-09", "2024-04-10"],
                "weather_code": [80, 61, 3, 45, 80, 45, 45],
                "temperature_2m_max": [18.4, 17.2, 24.9, 16.4, 14.6, 17.7, 29.0],
                "temperature_2m_min": [12.0, 13.0, 12.1, 12, 5.0, -3, 23.8]
            }
        
        }
        """
    guard let jsonData = jsonString.data(using: .utf8) else {
        // Handle the case where jsonString is nil or conversion fails
        print("Error converting jsonString to data")
        return Text("Invalid")
    }
    do {
        // Attempt JSON decoding
        let cityInfo = try JSONDecoder().decode(CityInfo.self, from: jsonData)
        return WeeklyView(cityInfo: cityInfo)
            .background(LinearGradient(
                gradient: Gradient(colors: [.purple.opacity(0.2), .indigo.opacity(0.8)]), startPoint: .top, endPoint: .bottom))
    } catch {
        // Handle decoding error
        print("Error decoding JSON:", error)
        return Text("Invalid previews")
    }
}
