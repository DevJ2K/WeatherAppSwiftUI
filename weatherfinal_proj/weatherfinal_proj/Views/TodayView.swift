//
//  TodayView.swift
//  weatherAppV2proj
//
//  Created by Théo Ajavon on 29/03/2024.
//

import SwiftUI

struct WeatherMap {
    static let data: [String: WeatherInfo] = [
        "0": WeatherInfo(dayDescription: "Sunny", nightDescription: "Clear", dayModel: "sunny", nightModel: "clear_moon", colorDay: [.yellow.opacity(0.97), .yellow.opacity(0.95)], colorNight: [.indigo.opacity(0.5), .indigo.opacity(0.7)], graphDayColor: .yellow, graphNightColor: .indigo, dayOpacity: 0.45, nightOpacity: 0.3),
    
        "1": WeatherInfo(dayDescription: "Mainly Sunny", nightDescription: "Mainly Clear", dayModel: "sunny", nightModel: "clear_moon", colorDay: [.yellow.opacity(0.97), .yellow.opacity(0.95)], colorNight: [.indigo.opacity(0.5), .indigo.opacity(0.7)], graphDayColor: .yellow, graphNightColor: .indigo, dayOpacity: 0.45, nightOpacity: 0.3),
        
        "2": WeatherInfo(dayDescription: "Partly Cloudy", nightDescription: "Partly Cloudy", dayModel: "partly_cloudy", nightModel: "cloudy_night", colorDay: [.cyan, Color(red: 0.3, green: 0.35, blue: 1.0)], colorNight: [.indigo.opacity(0.5), .indigo.opacity(0.7)], graphDayColor: .blue, graphNightColor: .indigo, dayOpacity: 0.45, nightOpacity: 0.3),
        
        "3": WeatherInfo(dayDescription: "Cloudy", nightDescription: "Cloudy", dayModel: "cloudy", nightModel: "cloudy_night", colorDay: [.cyan, Color(red: 0.1627, green: 0.7392, blue: 1.0)], colorNight: [.indigo.opacity(0.5), .indigo.opacity(0.4)], graphDayColor: .blue, graphNightColor: .indigo, dayOpacity: 0.5, nightOpacity: 0.3),
        
        "45":  WeatherInfo(dayDescription: "Foggy", nightDescription: "Foggy", dayModel: "cloudy", nightModel: "cloudy_fog", colorDay: [.gray, .gray.opacity(0.7)], colorNight: [.gray.opacity(0.5), .gray.opacity(0.3)], graphDayColor: .gray, graphNightColor: .gray, dayOpacity: 0.5, nightOpacity: 0.3),
        
        "48": WeatherInfo(dayDescription: "Rime Fog", nightDescription: "Rime Fog", dayModel: "solo_snow", nightModel: "solo_snow", colorDay: [.white, .cyan], colorNight: [ .gray.opacity(0.3), .blue.opacity(0.6)], graphDayColor: .cyan, graphNightColor: .blue, dayOpacity: 0.4, nightOpacity: 0.3),
        
        "51": WeatherInfo(dayDescription: "Light Drizzle", nightDescription: "Light Drizzle", dayModel: "light_rain", nightModel: "light_rain", colorDay: [.white.opacity(0.7), .white.opacity(0.5)], colorNight: [.white.opacity(0.3), .white.opacity(0.2)], graphDayColor: .white, graphNightColor: .white, dayOpacity: 0.5, nightOpacity: 0.3),
        
        "53": WeatherInfo(dayDescription: "Drizzle", nightDescription: "Drizzle", dayModel: "heavy_rain", nightModel: "heavy_rain", colorDay: [.gray, .gray.opacity(0.5)], colorNight: [.gray.opacity(0.1), .blue.opacity(0.3)], graphDayColor: .gray, graphNightColor: .indigo, dayOpacity: 0.5, nightOpacity: 0.3),
        
        "55": WeatherInfo(dayDescription: "Heavy Drizzle", nightDescription: "Heavy Drizzle", dayModel: "heavy_rain", nightModel: "heavy_rain", colorDay: [.gray.opacity(0.7), .gray.opacity(0.4)], colorNight: [.gray.opacity(0.2), .blue.opacity(0.2)], graphDayColor: .gray, graphNightColor: .blue.opacity(0.9), dayOpacity: 0.5, nightOpacity: 0.3),
        
        "56": WeatherInfo(dayDescription: "Light Freezing Drizzle", nightDescription: "Light Freezing Drizzle", dayModel: "light_rain", nightModel: "light_rain", colorDay: [.white.opacity(0.7), .white.opacity(0.5)], colorNight: [.white.opacity(0.3), .white.opacity(0.2)], graphDayColor: .white, graphNightColor: .white, dayOpacity: 0.35, nightOpacity: 0.3),
        
        "57": WeatherInfo(dayDescription: "Freezing Drizzle", nightDescription: "Freezing Drizzle", dayModel: "light_rain", nightModel: "light_rain", colorDay: [.white.opacity(0.8), .cyan], colorNight: [ .gray.opacity(0.3), .blue.opacity(0.4)], graphDayColor: .cyan, graphNightColor: .blue, dayOpacity: 0.5, nightOpacity: 0.3),
        
        "61": WeatherInfo(dayDescription: "Light Rain", nightDescription: "Light Rain", dayModel: "light_rain", nightModel: "light_rain", colorDay: [.cyan.opacity(0.8), Color(red: 0.1, green: 0.15, blue: 0.85)], colorNight: [.indigo.opacity(0.4), .blue.opacity(0.5)], graphDayColor: .blue, graphNightColor: .indigo, dayOpacity: 0.5, nightOpacity: 0.3),
        
        "63": WeatherInfo(dayDescription: "Rain", nightDescription: "Rain", dayModel: "light_rain", nightModel: "light_rain", colorDay: [.cyan.opacity(0.8), Color(red: 0.1, green: 0.15, blue: 0.85)], colorNight: [.indigo.opacity(0.4), .blue.opacity(0.5)], graphDayColor: .cyan, graphNightColor: .indigo, dayOpacity: 0.5, nightOpacity: 0.3),
             
        "65": WeatherInfo(dayDescription: "Heavy Rain", nightDescription: "Heavy Rain", dayModel: "heavy_rain", nightModel: "heavy_rain", colorDay: [.gray.opacity(0.3), .gray.opacity(0.2)], colorNight: [.gray.opacity(0.15), .gray.opacity(0.1)], graphDayColor: .gray, graphNightColor: .gray, dayOpacity: 0.5, nightOpacity: 0.3),
             
        "66": WeatherInfo(dayDescription: "Light Freezing Rain", nightDescription: "Light Freezing Rain", dayModel: "light_rain", nightModel: "light_rain", colorDay: [Color(red: 0.31, green: 0.35, blue: 0.65).opacity(0.8), .white.opacity(0.5)], colorNight: [.white.opacity(0.3), .white.opacity(0.2)], graphDayColor: .white, graphNightColor: .white, dayOpacity: 0.35, nightOpacity: 0.3),
             
        "67": WeatherInfo(dayDescription: "Freezing Rain", nightDescription: "Freezing Rain", dayModel: "light_rain", nightModel: "light_rain", colorDay: [.white.opacity(0.7), .white.opacity(0.5)], colorNight: [.white.opacity(0.3), .white.opacity(0.2)], graphDayColor: .white, graphNightColor: .white, dayOpacity: 0.5, nightOpacity: 0.3),
             
        "71": WeatherInfo(dayDescription: "Light Snow", nightDescription: "Light Snow", dayModel: "snowfall", nightModel: "night_snowfall", colorDay: [.white.opacity(0.9), Color(red: 120/255, green: 173/255, blue: 247/255)], colorNight: [.blue.opacity(0.2), Color(red: 120/255, green: 173/255, blue: 247/255).opacity(0.2)], graphDayColor: .cyan, graphNightColor: .indigo, dayOpacity: 0.4, nightOpacity: 0.3),
             
        "73": WeatherInfo(dayDescription: "Snow", nightDescription: "Snow", dayModel: "snowfall", nightModel: "night_snowfall", colorDay: [.white.opacity(0.9), Color(red: 120/255, green: 173/255, blue: 247/255)], colorNight: [.blue.opacity(0.2), Color(red: 120/255, green: 173/255, blue: 247/255).opacity(0.2)], graphDayColor: .cyan, graphNightColor: .indigo, dayOpacity: 0.4, nightOpacity: 0.3),
             
        "75": WeatherInfo(dayDescription: "Heavy Snow", nightDescription: "Heavy Snow", dayModel: "heavy_snow", nightModel: "heavy_snow", colorDay: [.white.opacity(0.9), Color(red: 120/255, green: 173/255, blue: 227/255)], colorNight: [.blue.opacity(0.2), Color(red: 120/255, green: 173/255, blue: 247/255).opacity(0.2)], graphDayColor: .cyan, graphNightColor: .indigo, dayOpacity: 0.4, nightOpacity: 0.3),
             
        "77": WeatherInfo(dayDescription: "Snow Grains", nightDescription: "Snow Grains", dayModel: "snowflake", nightModel: "snowflake", colorDay: [.white.opacity(0.9), Color(red: 120/255, green: 173/255, blue: 227/255)], colorNight: [.blue.opacity(0.2), Color(red: 120/255, green: 173/255, blue: 247/255).opacity(0.2)], graphDayColor: .white, graphNightColor: .indigo, dayOpacity: 0.4, nightOpacity: 0.3),
 
        
        "80": WeatherInfo(dayDescription: "Light Showers", nightDescription: "Light Showers", dayModel: "light_rain", nightModel: "light_rain", colorDay: [.cyan.opacity(0.8), Color(red: 0.1, green: 0.15, blue: 0.85)], colorNight: [.indigo.opacity(0.4), .blue.opacity(0.5)], graphDayColor: .cyan, graphNightColor: .indigo, dayOpacity: 0.3, nightOpacity: 0.3),
                    
        "81": WeatherInfo(dayDescription: "Showers", nightDescription: "Showers", dayModel: "light_rain", nightModel: "light_rain", colorDay: [.cyan.opacity(0.8), Color(red: 0.1, green: 0.15, blue: 0.85)], colorNight: [.indigo.opacity(0.4), .blue.opacity(0.5)], graphDayColor: .cyan, graphNightColor: .indigo, dayOpacity: 0.3, nightOpacity: 0.3),

        
                    
        "82": WeatherInfo(dayDescription: "Heavy Showers", nightDescription: "Heavy Showers", dayModel: "heavy_rain", nightModel: "heavy_rain", colorDay: [.gray.opacity(0.3), .gray.opacity(0.2)], colorNight: [.gray.opacity(0.15), .gray.opacity(0.1)], graphDayColor: .white, graphNightColor: .gray, dayOpacity: 0.3, nightOpacity: 0.3),
        
                    
        "85": WeatherInfo(dayDescription: "Light Snow Showers", nightDescription: "Light Snow Showers", dayModel: "snowfall", nightModel: "night_snowfall", colorDay: [.white.opacity(0.9), Color(red: 120/255, green: 173/255, blue: 247/255)], colorNight: [.blue.opacity(0.2), Color(red: 120/255, green: 173/255, blue: 247/255).opacity(0.2)], graphDayColor: .white, graphNightColor: .indigo, dayOpacity: 0.5, nightOpacity: 0.3),
        
                    
        "86": WeatherInfo(dayDescription: "Snow Showers", nightDescription: "Snow Showers", dayModel: "heavy_snow", nightModel: "heavy_snow", colorDay: [.white.opacity(0.9), Color(red: 120/255, green: 173/255, blue: 227/255)], colorNight: [.blue.opacity(0.2), Color(red: 120/255, green: 173/255, blue: 247/255).opacity(0.2)], graphDayColor: .white, graphNightColor: .indigo, dayOpacity: 0.4, nightOpacity: 0.3),
        
                    
        "95": WeatherInfo(dayDescription: "Thunderstorm", nightDescription: "Thunderstorm", dayModel: "thunderstorm", nightModel: "thunderstorm", colorDay: [.gray.opacity(0.2), .gray.opacity(0.3)], colorNight: [.black.opacity(0.1), .gray.opacity(0.15)], graphDayColor: .yellow, graphNightColor: .yellow, dayOpacity: 0.5, nightOpacity: 0.3),
        
                         
        "96": WeatherInfo(dayDescription: "Light Thunderstorms With Hail", nightDescription: "Light Thunderstorms With Hail", dayModel: "thunderstorm_with_hail", nightModel: "thunderstorm_with_hail", colorDay: [.gray.opacity(0.2), .gray.opacity(0.2)], colorNight: [.black.opacity(0.1), .gray.opacity(0.15)], graphDayColor: .yellow, graphNightColor: .yellow, dayOpacity: 0.5, nightOpacity: 0.3),
        
                         
        "99": WeatherInfo(dayDescription: "Thunderstorms With Hail", nightDescription: "Thunderstorms With Hail", dayModel: "big_thunderstorm_with_hail", nightModel: "big_thunderstorm_with_hail", colorDay: [.gray.opacity(0.15), .gray.opacity(0.15)], colorNight: [.black.opacity(0.1), .gray.opacity(0.10)], graphDayColor: .yellow, graphNightColor: .yellow, dayOpacity: 0.5, nightOpacity: 0.3),
    ]
}

struct TodayView: View {
    var cityInfo: CityInfo?
    
    var body: some View {
        if (cityInfo != nil) {
            ScrollView {
                VStack {
                    TodayChart(cityInfo: cityInfo, hourly: cityInfo?.hourly)
                    ScrollViewContent()
                }
            }
        } else {
            Text("Unable to display the data. Please try again.")
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
    
    func isSunsetHour(currentHour: String, sunsetTime: String?) -> Bool {
        guard let sunsetTime = sunsetTime else { return false }
        guard let sunsetHour = Int(sunsetTime.suffix(5).prefix(2)) else { return false }
        guard let currentHourInt = Int(currentHour) else { return false }
        if (currentHourInt == sunsetHour) {
            return true
        }
        return false
    }
    
    func isSunriseHour(currentHour: String, sunriseTime: String?) -> Bool {
        guard let sunriseTime = sunriseTime else { return false }
        guard let sunriseHour = Int(sunriseTime.suffix(5).prefix(2)) else { return false }
        guard let currentHourInt = Int(currentHour) else { return false }
        if (currentHourInt == sunriseHour) {
            return true
        }
        return false
    }
    
    
    func isNight(currentHour: String, sunsetTime: String?, sunriseTime: String?) -> Bool {
        guard let sunsetTime = sunsetTime else { return false }
        guard let sunriseTime = sunriseTime else { return false }
        guard let sunsetHour = Int(sunsetTime.suffix(5).prefix(2)) else { return false }
        guard let sunriseHour = Int(sunriseTime.suffix(5).prefix(2)) else { return false }
        guard let currentHourInt = Int(currentHour) else { return false }
        
//        print("\(currentHour) - \(sunriseHour) - \(sunsetHour)")
        if (currentHourInt <= sunriseHour || sunsetHour < currentHourInt) {
            return true
        }
        return false
        
    }
    
    @ViewBuilder
    func ScrollViewContent() -> some View {
        ScrollView(.horizontal) {
            HStack(spacing: 0) {
                if (cityInfo?.hourly != nil) {
                    ForEach(0 ..< min(24, cityInfo!.hourly!.time.count), id: \.self) { i in
                        let currentHour = getCurrentHour(timezone: cityInfo!.city?.timezone)
                        let i_hour = cityInfo!.hourly!.time[i].suffix(5).prefix(2)
                        HStack {
                            VStack(spacing: 12) {
                                if (currentHour == i_hour) {
                                    Text("Now")
                                        .font(.system(size: 14, weight: .bold))
                                } else {
                                    Text("\(i_hour)h")
                                        .font(.system(size: 14, weight: .semibold))
                                }
                                if (isNight(currentHour: String(i_hour), sunsetTime: cityInfo?.hourly?.sunset, sunriseTime: cityInfo?.hourly?.sunrise)) {
                                    MiniSceneView(sceneName: getWeatherInfo(weather_code: cityInfo!.hourly!.weather_code[i])?.nightModel ?? "")
                                        .frame(height: 40)
                                } else {
                                    
                                    MiniSceneView(sceneName: getWeatherInfo(weather_code: cityInfo!.hourly!.weather_code[i])?.dayModel ?? "")
                                        .frame(height: 40)
                                }
                                VStack(spacing: 4) {
                                    HStack(spacing: 4) {
                                        Image(systemName: getTempLogo(temperature: cityInfo!.hourly!.temperature_2m[i]))
                                            .font(.system(size: 14))
//                                            .opacity(0.8)
                                        Text("\(String(format: "%.1f", cityInfo!.hourly!.temperature_2m[i]))°")
                                            .font(.system(size: 14, weight: .bold))
//                                            .opacity(0.8)
                                    }
                                    HStack(spacing: 4) {
                                        Image(systemName: "wind")
                                            .font(.system(size: 14))
//                                            .opacity(0.8)
                                        Text("\(String(format: "%.1f", cityInfo!.hourly!.wind_speed_10m[i]))km/h")
                                            .font(.system(size: 14, weight: .light))
//                                            .opacity(0.8)
                                    }
                                }
                            }
                            .padding()
//                            cityInfo?.hourly?.sunrise
                            if (isSunriseHour(currentHour: String(i_hour), sunriseTime: cityInfo?.hourly?.sunrise)) {
                                VStack(spacing: 12) {
                                        Text("\(cityInfo!.hourly!.sunrise!.suffix(5))")
                                            .font(.system(size: 14, weight: .bold))
                                        Image(systemName: "sunrise.fill")
                                            .foregroundStyle(.white, .orange)
                                            .font(.system(size: 28))
                                            .frame(height: 40)
                                        Text("Sunrise")
                                            .font(.system(size: 18, weight: .semibold))
                                            .frame(height: 40)
                                }
                                .padding()
                            }
                            if (isSunsetHour(currentHour: String(i_hour), sunsetTime: cityInfo?.hourly?.sunset)) {
                                VStack(spacing: 12) {
                                        Text("\(cityInfo!.hourly!.sunset!.suffix(5))")
                                            .font(.system(size: 14, weight: .bold))
                                        Image(systemName: "sunset.fill")
                                            .foregroundStyle(.white, .orange)
                                            .font(.system(size: 28))
                                            .frame(height: 40)
                                        Text("Sunset")
                                            .font(.system(size: 18, weight: .semibold))   
                                            .frame(height: 40)
                                }
                                .padding()
                            }
                        }
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
                "weather_code": 95,
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
                                                                                                                                                                                                                                                                                                                                         25.1, 24.8, 24.5, 24.2, 23.9, 23.6, 23.3, 23.0],
                "sunrise": "2024-04-04T04:09",
                "sunset": "2024-04-04T18:09",
            },
            "daily": {
                "time": ["2024-04-04", "2024-04-05", "2024-04-06"],
                "weather_code": [80, 61, 3],
                "temperature_2m_max": [18.4, 17.2, 24.9],
                "temperature_2m_min": [12.0, 13.0, 12.1],
                "sunset": ["2024-04-04T04:09", "2024-04-05T04:09", "2024-04-04T06:09"],
                "sunrise": ["2024-04-04T18:09", "2024-04-05T18:09", "2024-04-06T18:09"],
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
