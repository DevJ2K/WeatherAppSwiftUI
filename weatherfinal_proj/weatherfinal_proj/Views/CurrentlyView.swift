//
//  CurrentlyView.swift
//  weatherAppV2proj
//
//  Created by Théo Ajavon on 29/03/2024.
//

import SwiftUI

struct CurrentlyView: View {
    var cityInfo: CityInfo?
    
    var body: some View {
        VStack {
//            Spacer()
            Text(cityInfo?.city?.name ?? "Unknown")
                .bold()
                .font(.largeTitle)
            HStack {
                Text(cityInfo?.city?.admin1 ?? "Unknown")
                    .font(.title3)
                + Text(", ")
                    .font(.title3)
                + Text(cityInfo?.city?.country ?? "Unknown")
                    .font(.title3)
            }
//            Spacer()
//            VStack(spacing: 0) {
                
                CustomSceneView(sceneName: "cloudy_night.scn")
                    .frame(height: 200)
                VStack(spacing: 6) {
                    if (cityInfo?.current?.temperature_2m != nil) {
                        Text("\(String(format: "%.f", cityInfo!.current!.temperature_2m))°")
                            .font(.system(size: 72))
                            .fontWeight(.bold)
                            .frame(height: 56)
//                            .background(.red)
                    }
                    if (cityInfo?.current?.weather_code != nil) {
                        Text("\(getWeatherDescription(weather_code: cityInfo!.current!.weather_code)?.dayDescription ?? "")")
                            .font(.system(size: 18))
                            .fontWeight(.medium)
                    }
                }
//            }
            
            CurrentInfoDash(wind_speed: cityInfo?.current?.wind_speed_10m, humidity: cityInfo?.current?.relative_humidity_2m, precipitation_probability: cityInfo?.current?.precipitation_probability)
            
//            Spacer()
        }
//        .background(LinearGradient(colors: [Color.indigo.opacity(0.2), Color.indigo.opacity(0.6)], startPoint: .top, endPoint: .bottom))
        .ignoresSafeArea(.all)
    }
}

#Preview {
    return ContentView()
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
                "relative_humidity_2m": 43,
                "precipitation_probability": 74,
                "weather_code": 80,
                "wind_speed_10m": 18.9
            },
            "hourly": {
                "time": ["2024-04-04T00:00", "2024-04-04T01:00", "2024-04-04T02:00", "2024-04-04T03:00"],
                "temperature_2m": [13.0, 12.8, 13.3, 13.2],
                "weather_code": [2, 61, 61, 61],
                "wind_speed_10m": [18.2, 17.3, 18.7, 17.2]
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
        return CurrentlyView(cityInfo: cityInfo)
    } catch {
        // Handle decoding error
        print("Error decoding JSON:", error)
        return Text("Invalid previews")
    }
}
