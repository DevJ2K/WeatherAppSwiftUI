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
