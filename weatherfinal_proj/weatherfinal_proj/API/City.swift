//
//  City.swift
//  weatherAppV2proj
//
//  Created by Théo Ajavon on 01/04/2024.
//
//        https://geocoding-api.open-meteo.com/v1/search?name=&count=10&language=en&format=json

import Foundation
import SwiftUI
import SceneKit


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
    var sunrise: String?
    var sunset: String?
}

struct WeeklyData: Codable {
    var time: Array<String>
    var weather_code: Array<Int8>
    var temperature_2m_min: Array<Double>
    var temperature_2m_max: Array<Double>
    var sunrise: Array<String>
    var sunset: Array<String>
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

func getWeatherInfo(weather_code: Int8?) -> WeatherInfo? {
    if (weather_code == nil) {
        return nil
    }
//    print(weather_code!)
    return (WeatherMap.data["\(weather_code!)"] ?? nil)
}

//let models3D = {
//    var dictionnary: [String: SCNScene?] = [:]
//    let all_models: [String] = ["clear_moon", "cloudy_night", "cloudy", "heavy_rain", "heavy_snow", "light_rain", "light_thunderstorm", "partly_cloudy", "snowfall", "sunny", "thunder_cloud", "thunderstorm_with_hail", "thunderstorm"]
//    
//    for modelString in all_models {
//        if let sceneUrl = Bundle.main.url(forResource: modelString, withExtension: "scn") {
//            do {
//                let scene = try SCNScene(url: sceneUrl, options: nil)
//                dictionnary[modelString] = scene
//            } catch {
//                print("Failed to load 3D models : \(modelString)")
//            }
//        }
//    }
//    print(dictionnary)
//    return dictionnary
//}()

let models3D: [String: SCNScene?] = [:]

func get3DModel(sceneName: String) -> SCNScene? {
    if let model = models3D[sceneName] {
        return model
    }
    return nil
}

//func getModelByWeatherCode(isDay: Int8?, weather_code: Int8?) -> String {
//    guard let weatherInfo = getWeatherInfo(weather_code: weather_code) else { return "" }
//    if (isDay == nil || isDay == 1) {
//        return weatherInfo.dayModel
//    } else {
//        return weatherInfo.nightModel
//    }
//}



func getRealBackground(cityInfo: CityInfo?, weatherInfo: WeatherInfo?, showSearchBar: Bool) -> LinearGradient {
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
            gradient: Gradient(colors: [.purple.opacity(0.7), .indigo.opacity(0.9)]), startPoint: .top, endPoint: .bottom)
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
    var cityInfo = CityInfo(city: city)
    var urlString = "https://api.open-meteo.com/v1/forecast?latitude=\(city.latitude)&longitude=\(city.longitude)&current=temperature_2m,relative_humidity_2m,precipitation_probability,is_day,weather_code,wind_speed_10m&hourly=temperature_2m,weather_code,wind_speed_10m&daily=weather_code,temperature_2m_max,temperature_2m_min,sunrise,sunset"
    if (city.timezone != nil) {
        urlString += "&timezone=\(city.timezone!)"
    }
    guard let url = URL(string: urlString) else {
        print("This request has failed please try with an other URL...")
        return nil
    }
//    print(urlString)
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
        
        cityInfo.hourly?.sunrise = cityInfo.daily?.sunrise[0]
        cityInfo.hourly?.sunset = cityInfo.daily?.sunset[0]
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
//    print(urlString)
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
