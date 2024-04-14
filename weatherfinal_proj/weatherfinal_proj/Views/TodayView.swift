//
//  TodayView.swift
//  weatherAppV2proj
//
//  Created by Théo Ajavon on 29/03/2024.
//

import SwiftUI

struct TodayView: View {
    var cityInfo: CityInfo?
    
    var body: some View {
        ScrollView {
            VStack {
                TodayChart(cityInfo: cityInfo, hourly: cityInfo?.hourly)
                ScrollViewContent()
            }
        }
    }
    
    func getTempLogo(temperature: Double) -> String {
        if (temperature > 25) {
            return ("thermometer.high")
        } else if (temperature > 15) {
            return ("thermometer.medium")
        } else {
            return ("thermometer.low")
        }
    }
    
    func getCurrentHour(timezone: String?) -> String {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        if (timezone != nil) {
            dateFormatter.timeZone = TimeZone(identifier: timezone!)
        }
        let currentHourString = dateFormatter.string(from: currentDate)
        return currentHourString
    }
    
    @ViewBuilder
    func ScrollViewContent() -> some View {
        ScrollView(.horizontal) {
            HStack(spacing: 0) {
                if (cityInfo?.hourly != nil) {
                    ForEach(0 ..< min(24, cityInfo!.hourly!.time.count), id: \.self) { i in
                        let currentHour = getCurrentHour(timezone: cityInfo!.city?.timezone)
                        let i_hour = cityInfo!.hourly!.time[i].suffix(5).prefix(2)
                        VStack(spacing: 12) {
                            if (currentHour == i_hour) {
                                Text("Now")
                                    .font(.system(size: 14, weight: .bold))
                            } else {
                                Text("\(i_hour)h")
                                    .font(.system(size: 14, weight: .semibold))
                            }
//                            Text("\(getWeatherDescription(weather_code: cityInfo!.hourly!.weather_code[i])?.dayDescription ?? "")")
                            MiniSceneView(sceneName: "cloudy_night")
                                .frame(height: 40)
                            VStack(spacing: 4) {
                                HStack(spacing: 4) {
                                    Image(systemName: getTempLogo(temperature: cityInfo!.hourly!.temperature_2m[i]))
                                        .font(.system(size: 14))
                                        .opacity(0.8)
                                    Text("\(String(format: "%.1f", cityInfo!.hourly!.temperature_2m[i]))°")
                                        .font(.system(size: 14, weight: .bold))
                                        .opacity(0.8)
                                }
                                HStack(spacing: 4) {
                                    Image(systemName: "wind")
                                        .font(.system(size: 14))
                                        .opacity(0.8)
                                    Text("\(String(format: "%.1f", cityInfo!.hourly!.wind_speed_10m[i]))km/h")
                                        .font(.system(size: 14, weight: .light))
                                        .opacity(0.8)
                                }
                            }
                        }
                        .padding()
//                        .background(.blue.gradient)
                    }
                }
            }
        }
        .background(.black.opacity(getOpacityByWeather(cityInfo: cityInfo)))
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
                "weather_code": [2, 61, 61, 61, 61, 61, 45, 53, 53, 53, 53, 53, 53, 53, 53, 53, 53, 53, 53, 61, 61, 61, 61, 61, 61, 61, 61, 86, 95],
                "wind_speed_10m": [18.2, 17.3, 18.7, 17.2, 19, 20.1, 21.5, 22.3, 23.6, 24.9, 25.3, 25.8, 26.2, 26.5, 26.7, 26.8, 26.6, 26.3, 26.0, 25.7, 25.4,
                                                                                                                                                                                                                                                                                                                                         25.1, 24.8, 24.5, 24.2, 23.9, 23.6, 23.3, 23.0]
            },
            "daily": {
                "time": ["2024-04-04", "2024-04-05", "2024-04-06"],
                "weather_code": [80, 61, 3],
                "temperature_2m_max": [18.4, 17.2, 24.9],
                "temperature_2m_min": [12.0, 13.0, 12.1]
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
        return TodayView(cityInfo: cityInfo)
            .background(getRealBackground(cityInfo: cityInfo, weatherInfo: getWeatherInfo(weather_code: cityInfo.current?.weather_code), showSearchBar: false))
    } catch {
        // Handle decoding error
        print("Error decoding JSON:", error)
        return Text("Invalid previews")
    }
}
