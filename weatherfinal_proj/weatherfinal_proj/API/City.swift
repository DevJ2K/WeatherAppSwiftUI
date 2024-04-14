//
//  City.swift
//  weatherAppV2proj
//
//  Created by Théo Ajavon on 01/04/2024.
//
//        https://geocoding-api.open-meteo.com/v1/search?name=&count=10&language=en&format=json

import Foundation
import SwiftUI


struct CityResult: Codable {
    var results: [City]
}

struct City: Codable {
    var id: Int
    var name: String
    var latitude: Double
    var longitude: Double
    var elevation: Int?
    var timezone: String?
    var country: String?
    var admin1: String? //  Région
}

struct CityInfo: Codable {
    var city: City?
    
    // CURRENT TAB
    var current: CurrentData?
    // TODAY TAB
    var hourly: HourlyData?
    
    var daily: WeeklyData?
    // WEEKLY TAB
    //    var weatherDateList: [Array<AnyObject>]
}

struct CurrentData: Codable {
    var time: String
    var temperature_2m: Double
    var is_day: Int8
    var weather_code: Int8
    var relative_humidity_2m: Int8?
    var precipitation_probability: Int8?
    var wind_speed_10m: Double
}

struct HourlyData: Codable {
    var time: Array<String>
    var temperature_2m: Array<Double>
    var weather_code: Array<Int8>
    var wind_speed_10m: Array<Double>
}

struct WeeklyData: Codable {
    var time: Array<String>
    var weather_code: Array<Int8>
    var temperature_2m_max: Array<Double>
    var temperature_2m_min: Array<Double>
}



struct WeatherInfo {
    let dayDescription: String
    let nightDescription: String
    let dayModel: String
    let nightModel: String
    let colorDay: [Color]
    let colorNight: [Color]
    let graphDayColor: Color
    let graphNightColor: Color
    let dayOpacity: Double
    let nightOpacity: Double
}

struct WeatherMap {
    static let data: [String: WeatherInfo] = [
        "0": WeatherInfo(dayDescription: "Sunny", nightDescription: "Clear", dayModel: "sunny", nightModel: "cloudy_night", colorDay: [.yellow, .orange], colorNight: [.indigo.opacity(0.7), .blue], graphDayColor: .yellow, graphNightColor: .indigo, dayOpacity: 0.5, nightOpacity: 0.3),
        
        "1": WeatherInfo(dayDescription: "Mainly Sunny", nightDescription: "Mainly Clear", dayModel: "sunny", nightModel: "cloudy_night", colorDay: [.yellow.opacity(0.9), .orange], colorNight: [.indigo.opacity(0.1), .blue], graphDayColor: .yellow, graphNightColor: .indigo, dayOpacity: 0.5, nightOpacity: 0.3),
        
        "2": WeatherInfo(dayDescription: "Partly Cloudy", nightDescription: "Partly Cloudy", dayModel: "cloudy", nightModel: "cloudy_night", colorDay: [.blue, .blue.opacity(0.7)], colorNight: [.indigo.opacity(0.7), .blue], graphDayColor: .blue, graphNightColor: .indigo, dayOpacity: 0.5, nightOpacity: 0.3),
        
        "3": WeatherInfo(dayDescription: "Cloudy", nightDescription: "Cloudy", dayModel: "cloudy", nightModel: "cloudy_night", colorDay: [.gray, .gray.opacity(0.7)], colorNight: [.indigo.opacity(0.7), .blue], graphDayColor: .gray, graphNightColor: .indigo, dayOpacity: 0.5, nightOpacity: 0.3),
        
        "45":  WeatherInfo(dayDescription: "Foggy", nightDescription: "Foggy", dayModel: "cloudy", nightModel: "cloudy_night", colorDay: [.gray, .gray.opacity(0.7)], colorNight: [.indigo.opacity(0.7), .blue], graphDayColor: .gray, graphNightColor: .indigo, dayOpacity: 0.5, nightOpacity: 0.3),
        
        "48": WeatherInfo(dayDescription: "Rime Fog", nightDescription: "Rime Fog", dayModel: "thunder_cloud", nightModel: "thunder_cloud", colorDay: [.yellow, .orange], colorNight: [.indigo.opacity(0.7), .blue], graphDayColor: .yellow, graphNightColor: .indigo, dayOpacity: 0.5, nightOpacity: 0.3),
        
        "51": WeatherInfo(dayDescription: "Light Drizzle", nightDescription: "Light Drizzle", dayModel: "light_rain", nightModel: "light_rain", colorDay: [.yellow, .orange], colorNight: [.indigo.opacity(0.7), .blue], graphDayColor: .yellow, graphNightColor: .indigo, dayOpacity: 0.5, nightOpacity: 0.3),
        
        "53": WeatherInfo(dayDescription: "Drizzle", nightDescription: "Drizzle", dayModel: "heavy_rain", nightModel: "heavy_rain", colorDay: [.gray, .gray.opacity(0.5)], colorNight: [.indigo.opacity(0.7), .blue], graphDayColor: .gray, graphNightColor: .indigo, dayOpacity: 0.5, nightOpacity: 0.3),
        
        "55": WeatherInfo(dayDescription: "Heavy Drizzle", nightDescription: "Heavy Drizzle", dayModel: "heavy_rain", nightModel: "heavy_rain", colorDay: [.gray.opacity(0.3), .gray.opacity(0.1)], colorNight: [.indigo.opacity(0.7), .blue], graphDayColor: .gray, graphNightColor: .indigo, dayOpacity: 0.5, nightOpacity: 0.3),
        
        "56": WeatherInfo(dayDescription: "Light Freezing Drizzle", nightDescription: "Light Freezing Drizzle", dayModel: "light_rain", nightModel: "light_rain", colorDay: [.yellow, .orange], colorNight: [.indigo.opacity(0.7), .blue], graphDayColor: .yellow, graphNightColor: .indigo, dayOpacity: 0.5, nightOpacity: 0.3),
        
        "57": WeatherInfo(dayDescription: "Freezing Drizzle", nightDescription: "Freezing Drizzle", dayModel: "snowfall", nightModel: "snowfall", colorDay: [.yellow, .orange], colorNight: [.indigo.opacity(0.7), .blue], graphDayColor: .yellow, graphNightColor: .indigo, dayOpacity: 0.5, nightOpacity: 0.3),
        
        "61": WeatherInfo(dayDescription: "Light Rain", nightDescription: "Light Rain", dayModel: "light_rain", nightModel: "light_rain", colorDay: [.yellow, .orange], colorNight: [.indigo.opacity(0.7), .blue], graphDayColor: .yellow, graphNightColor: .indigo, dayOpacity: 0.5, nightOpacity: 0.3),
        
        "63": WeatherInfo(dayDescription: "Rain", nightDescription: "Rain", dayModel: "light_rain", nightModel: "light_rain", colorDay: [.yellow, .orange], colorNight: [.indigo.opacity(0.7), .blue], graphDayColor: .yellow, graphNightColor: .indigo, dayOpacity: 0.5, nightOpacity: 0.3),
             
        "65": WeatherInfo(dayDescription: "Heavy Rain", nightDescription: "Heavy Rain", dayModel: "heavy_rain", nightModel: "heavy_rain", colorDay: [.yellow, .orange], colorNight: [.indigo.opacity(0.7), .blue], graphDayColor: .yellow, graphNightColor: .indigo, dayOpacity: 0.5, nightOpacity: 0.3),
             
        "66": WeatherInfo(dayDescription: "Light Freezing Rain", nightDescription: "Light Freezing Rain", dayModel: "snowfall", nightModel: "snowfall", colorDay: [.yellow, .orange], colorNight: [.indigo.opacity(0.7), .blue], graphDayColor: .yellow, graphNightColor: .indigo, dayOpacity: 0.5, nightOpacity: 0.3),
             
        "67": WeatherInfo(dayDescription: "Freezing Rain", nightDescription: "Freezing Rain", dayModel: "snowfall", nightModel: "snowfall", colorDay: [.yellow, .orange], colorNight: [.indigo.opacity(0.7), .blue], graphDayColor: .yellow, graphNightColor: .indigo, dayOpacity: 0.5, nightOpacity: 0.3),
             
        "71": WeatherInfo(dayDescription: "Light Snow", nightDescription: "Light Snow", dayModel: "snowfall", nightModel: "snowfall", colorDay: [.yellow, .orange], colorNight: [.indigo.opacity(0.7), .blue], graphDayColor: .yellow, graphNightColor: .indigo, dayOpacity: 0.5, nightOpacity: 0.3),
             
        "73": WeatherInfo(dayDescription: "Snow", nightDescription: "Snow", dayModel: "heavy_snow", nightModel: "heavy_snow", colorDay: [.yellow, .orange], colorNight: [.indigo.opacity(0.7), .blue], graphDayColor: .yellow, graphNightColor: .indigo, dayOpacity: 0.5, nightOpacity: 0.3),
             
        "75": WeatherInfo(dayDescription: "Heavy Snow", nightDescription: "Heavy Snow", dayModel: "heavy_snow", nightModel: "heavy_snow", colorDay: [.yellow, .orange], colorNight: [.indigo.opacity(0.7), .blue], graphDayColor: .yellow, graphNightColor: .indigo, dayOpacity: 0.5, nightOpacity: 0.3),
             
        "77": WeatherInfo(dayDescription: "Snow Grains", nightDescription: "Snow Grains", dayModel: "snowfall", nightModel: "snowfall", colorDay: [.yellow, .orange], colorNight: [.indigo.opacity(0.7), .blue], graphDayColor: .yellow, graphNightColor: .indigo, dayOpacity: 0.5, nightOpacity: 0.3),
 
        
        "80": WeatherInfo(dayDescription: "Light Showers", nightDescription: "Light Showers", dayModel: "light_rain", nightModel: "light_rain", colorDay: [.indigo.opacity(0.8), .indigo.opacity(0.4)], colorNight: [.indigo.opacity(0.7), .blue], graphDayColor: .yellow, graphNightColor: .indigo, dayOpacity: 0.5, nightOpacity: 0.3),
                    
        "81": WeatherInfo(dayDescription: "Showers", nightDescription: "Showers", dayModel: "light_rain", nightModel: "light_rain", colorDay: [.yellow, .orange], colorNight: [.indigo.opacity(0.7), .blue], graphDayColor: .yellow, graphNightColor: .indigo, dayOpacity: 0.5, nightOpacity: 0.3),
        
                    
        "82": WeatherInfo(dayDescription: "Heavy Showers", nightDescription: "Heavy Showers", dayModel: "heavy_rain", nightModel: "heavy_rain", colorDay: [.yellow, .orange], colorNight: [.indigo.opacity(0.7), .blue], graphDayColor: .yellow, graphNightColor: .indigo, dayOpacity: 0.5, nightOpacity: 0.3),
        
                    
        "85": WeatherInfo(dayDescription: "Light Snow Showers", nightDescription: "Light Snow Showers", dayModel: "snowfall", nightModel: "snowfall", colorDay: [.yellow, .orange], colorNight: [.indigo.opacity(0.7), .blue], graphDayColor: .yellow, graphNightColor: .indigo, dayOpacity: 0.5, nightOpacity: 0.3),
        
                    
        "86": WeatherInfo(dayDescription: "Snow Showers", nightDescription: "Snow Showers", dayModel: "snowfall", nightModel: "snowfall", colorDay: [.yellow, .orange], colorNight: [.indigo.opacity(0.7), .blue], graphDayColor: .yellow, graphNightColor: .indigo, dayOpacity: 0.5, nightOpacity: 0.3),
        
                    
        "95": WeatherInfo(dayDescription: "Thunderstorm", nightDescription: "Thunderstorm", dayModel: "light_thunderstorm", nightModel: "light_thunderstorm", colorDay: [.yellow, .orange], colorNight: [.indigo.opacity(0.7), .blue], graphDayColor: .yellow, graphNightColor: .indigo, dayOpacity: 0.5, nightOpacity: 0.3),
        
                         
        "96": WeatherInfo(dayDescription: "Light Thunderstorms With Hail", nightDescription: "Light Thunderstorms With Hail", dayModel: "thunderstorm_with_hail", nightModel: "thunderstorm_with_hail", colorDay: [.yellow, .orange], colorNight: [.indigo.opacity(0.7), .blue], graphDayColor: .yellow, graphNightColor: .indigo, dayOpacity: 0.5, nightOpacity: 0.3),
        
                         
        "99": WeatherInfo(dayDescription: "Light Thunderstorms With Hail", nightDescription: "Light Thunderstorms With Hail", dayModel: "thunderstorm_with_hail", nightModel: "thunderstorm_with_hail", colorDay: [.yellow, .orange], colorNight: [.indigo.opacity(0.7), .blue], graphDayColor: .yellow, graphNightColor: .indigo, dayOpacity: 0.5, nightOpacity: 0.3),
    ]
}

func getWeatherInfo(weather_code: Int8?) -> WeatherInfo? {
    if (weather_code == nil) {
        return nil
    }
    print(weather_code!)
    return (WeatherMap.data["\(weather_code!)"] ?? nil)
}

func getRealBackground(cityInfo: CityInfo?, weatherInfo: WeatherInfo?, showSearchBar: Bool) -> LinearGradient {
    print(":::::")
    print(cityInfo?.current?.is_day ?? 3)
    if (showSearchBar) {
        return LinearGradient(colors: [Color.black], startPoint: .center, endPoint: .center)
    } else if (weatherInfo != nil) {
        if (cityInfo?.current?.is_day == 0) {
            return LinearGradient(colors: weatherInfo!.colorNight, startPoint: .top, endPoint: .bottom)
        } else {
            return  LinearGradient(colors: weatherInfo!.colorDay, startPoint: .top, endPoint: .bottom)
        }
    } else {
        return LinearGradient(
            gradient: Gradient(colors: [.purple.opacity(0.2), .indigo.opacity(0.8)]), startPoint: .top, endPoint: .bottom)
    }
}

func getGradientGraph(cityInfo: CityInfo?) -> [Color] {
    let weatherInfo: WeatherInfo? = getWeatherInfo(weather_code: cityInfo?.current?.weather_code)
    if (weatherInfo == nil) {
        return [.white, .white.opacity(0.7), .white.opacity(0.05)]
    }
    if (cityInfo?.current?.is_day == 1) {
        return [weatherInfo!.graphDayColor, weatherInfo!.graphDayColor.opacity(0.7), weatherInfo!.graphDayColor.opacity(0.05)]
    } else {
        return [weatherInfo!.graphNightColor, weatherInfo!.graphNightColor.opacity(0.7), weatherInfo!.graphNightColor.opacity(0.05)]
    }
}

func getGraphLineColor(cityInfo: CityInfo?) -> Color {
    let weatherInfo: WeatherInfo? = getWeatherInfo(weather_code: cityInfo?.current?.weather_code)
    if (weatherInfo == nil) {
        return .white
    }
    if (cityInfo?.current?.is_day == 1) {
        return weatherInfo!.graphDayColor
    } else {
        return weatherInfo!.graphNightColor
    }
}

func getOpacityByWeather(cityInfo: CityInfo?) -> Double {
    let weatherInfo: WeatherInfo? = getWeatherInfo(weather_code: cityInfo?.current?.weather_code)
    if (weatherInfo == nil) {
        return 0.5
    }
    if (cityInfo?.current?.is_day == 1) {
        return weatherInfo!.dayOpacity
    } else {
        return weatherInfo!.nightOpacity
    }
}

func fetchCityInfo(city: City) async -> CityInfo? {
    //    var currentTabUrlString = "https://api.open-meteo.com/v1/forecast?latitude=\(city.latitude)&longitude=\(city.longitude)&current=temperature_2m,is_day,weather_code,wind_speed_10m"
    //    var todayTabUrlString = "https://api.open-meteo.com/v1/forecast?latitude=\(city.latitude)&longitude=\(city.longitude)&hourly=temperature_2m,weather_code,wind_speed_10m&forecast_days=1"
    //    var weeklyTabUrlString = "https://api.open-meteo.com/v1/forecast?latitude=\(city.latitude)&longitude=\(city.longitude)&daily=weather_code,temperature_2m_max,temperature_2m_min"
    //
    //    if (city.timezone != nil) {
    //        currentTabUrlString += "&timezone=\(city.timezone!)"
    //        todayTabUrlString += "&timezone=\(city.timezone!)"
    //        weeklyTabUrlString += "&timezone=\(city.timezone!)"
    //    }
    //
    //    guard let currentTabUrl = URL(string: currentTabUrlString) else {
    //        print("CURRENT TAB : This request has failed please try with an other URL...")
    //        return nil
    //    }
    //    guard let todayTabUrl = URL(string: todayTabUrlString) else {
    //        print("TODAY TAB : This request has failed please try with an other URL...")
    //        return nil
    //    }
    //    guard let weeklyTabUrl = URL(string: weeklyTabUrlString) else {
    //        print("WEEKLY TAB : This request has failed please try with an other URL...")
    //        return nil
    //    }
    var cityInfo = CityInfo(city: city)
    var urlString = "https://api.open-meteo.com/v1/forecast?latitude=\(city.latitude)&longitude=\(city.longitude)&current=temperature_2m,relative_humidity_2m,precipitation_probability,is_day,weather_code,wind_speed_10m&hourly=temperature_2m,weather_code,wind_speed_10m&daily=weather_code,temperature_2m_max,temperature_2m_min"
    if (city.timezone != nil) {
        urlString += "&timezone=\(city.timezone!)"
    }
    guard let url = URL(string: urlString) else {
        print("This request has failed please try with an other URL...")
        return nil
    }
    do {
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            print("Invalid status code != 200")
            return nil
        }
        let decodedResponse = try JSONDecoder().decode(CityInfo.self, from: data)
        
        cityInfo.current = decodedResponse.current
        cityInfo.hourly = decodedResponse.hourly
        cityInfo.daily = decodedResponse.daily
        //        print("HERE !")
        return cityInfo
        
    } catch {
        print("Failed to fetch data")
    }
    
    return nil
}

func fetchCity(name: String) async -> [City] {
    //    print("0")
    DispatchQueue.main.async {
        LocationManager.shared.isFetchingCityList = true
    }
    let urlString = "https://geocoding-api.open-meteo.com/v1/search?name=\(name)&count=5&language=en&format=json"
    print(urlString)
    // Create URL
    guard let url = URL(string: urlString) else {
        print("This request has failed please try with an other URL...")
        DispatchQueue.main.async {
            LocationManager.shared.isFetchingCityList = false
        }
        return []
    }
    
    // Fetch data from the URL
    do {
        //        print("1")
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            print("Invalid status code != 200")
            LocationManager.shared.isFetchingCityList = false
            return []
        }
        //        print("2")
        // decode the data
        let decodedResponse = try JSONDecoder().decode(CityResult.self, from: data)
        //        print("3")
        //        print(decodedResponse.results)
        DispatchQueue.main.async {
            LocationManager.shared.isFetchingCityList = false
        }
        return decodedResponse.results
    } catch {
        print("Failed to fetch the data : \(error)")
        DispatchQueue.main.async {
            LocationManager.shared.isFetchingCityList = false
        }
        return []
    }
}
