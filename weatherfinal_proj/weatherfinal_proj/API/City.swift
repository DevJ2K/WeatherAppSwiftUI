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
    let backgroundDay: LinearGradient
    let backgroundNight: LinearGradient
    let colorDay: [Color]
    let colorNight: [Color]
//    let dayOpacity: Double
//    let nightOpacity: Double
}

struct WeatherMap {
    static let data: [String: WeatherInfo] = [
        "0": WeatherInfo(dayDescription: "Sunny", nightDescription: "Clear", dayModel: "sunny", nightModel: "cloudy_night", backgroundDay: LinearGradient(colors: [.yellow, .orange], startPoint: .top, endPoint: .bottom), backgroundNight: LinearGradient(colors: [.indigo.opacity(0.7), .blue], startPoint: .top, endPoint: .bottom), colorDay: [.yellow, .orange], colorNight: [.indigo.opacity(0.7), .blue]),
        
        "1": WeatherInfo(dayDescription: "Mainly Sunny", nightDescription: "Mainly Clear", dayModel: "sunny", nightModel: "cloudy_night", backgroundDay: LinearGradient(colors: [.yellow.opacity(0.9), .orange], startPoint: .top, endPoint: .bottom), backgroundNight: LinearGradient(colors: [.indigo.opacity(0.7), .blue], startPoint: .top, endPoint: .bottom), colorDay: [.yellow, .orange], colorNight: [.indigo.opacity(0.7), .blue]),
        
        "2": WeatherInfo(dayDescription: "Partly Cloudy", nightDescription: "Partly Cloudy", dayModel: "cloudy", nightModel: "cloudy_night", backgroundDay: LinearGradient(colors: [.blue, .blue.opacity(0.7)], startPoint: .top, endPoint: .bottom), backgroundNight: LinearGradient(colors: [.indigo.opacity(0.7), .blue], startPoint: .top, endPoint: .bottom), colorDay: [.yellow, .orange], colorNight: [.indigo.opacity(0.7), .blue]),
        
        "3": WeatherInfo(dayDescription: "Cloudy", nightDescription: "Cloudy", dayModel: "cloudy", nightModel: "cloudy_night", backgroundDay: LinearGradient(colors: [.gray, .gray.opacity(0.7)], startPoint: .top, endPoint: .bottom), backgroundNight: LinearGradient(colors: [.indigo.opacity(0.7), .blue], startPoint: .top, endPoint: .bottom), colorDay: [.yellow, .orange], colorNight: [.indigo.opacity(0.7), .blue]),
        
        "45":  WeatherInfo(dayDescription: "Foggy", nightDescription: "Foggy", dayModel: "cloudy", nightModel: "cloudy_night", backgroundDay: LinearGradient(colors: [.gray, .gray.opacity(0.7)], startPoint: .top, endPoint: .bottom), backgroundNight: LinearGradient(colors: [.indigo.opacity(0.7), .blue], startPoint: .top, endPoint: .bottom), colorDay: [.yellow, .orange], colorNight: [.indigo.opacity(0.7), .blue]),
        
        "48": WeatherInfo(dayDescription: "Rime Fog", nightDescription: "Rime Fog", dayModel: "thunder_cloud", nightModel: "thunder_cloud", backgroundDay: LinearGradient(colors: [.yellow, .orange], startPoint: .top, endPoint: .bottom), backgroundNight: LinearGradient(colors: [.indigo.opacity(0.7), .blue], startPoint: .top, endPoint: .bottom), colorDay: [.yellow, .orange], colorNight: [.indigo.opacity(0.7), .blue]),
        
        "51": WeatherInfo(dayDescription: "Light Drizzle", nightDescription: "Light Drizzle", dayModel: "light_rain", nightModel: "light_rain", backgroundDay: LinearGradient(colors: [.yellow, .orange], startPoint: .top, endPoint: .bottom), backgroundNight: LinearGradient(colors: [.indigo.opacity(0.7), .blue], startPoint: .top, endPoint: .bottom), colorDay: [.yellow, .orange], colorNight: [.indigo.opacity(0.7), .blue]),
        
        "53": WeatherInfo(dayDescription: "Drizzle", nightDescription: "Drizzle", dayModel: "heavy_rain", nightModel: "heavy_rain", backgroundDay: LinearGradient(colors: [.gray, .gray.opacity(0.5)], startPoint: .top, endPoint: .bottom), backgroundNight: LinearGradient(colors: [.indigo.opacity(0.7), .blue], startPoint: .top, endPoint: .bottom), colorDay: [.yellow, .orange], colorNight: [.indigo.opacity(0.7), .blue]),
        
        "55": WeatherInfo(dayDescription: "Heavy Drizzle", nightDescription: "Heavy Drizzle", dayModel: "heavy_rain", nightModel: "heavy_rain", backgroundDay: LinearGradient(colors: [.gray.opacity(0.3), .gray.opacity(0.1)], startPoint: .top, endPoint: .bottom), backgroundNight: LinearGradient(colors: [.indigo.opacity(0.7), .blue], startPoint: .top, endPoint: .bottom), colorDay: [.yellow, .orange], colorNight: [.indigo.opacity(0.7), .blue]),
        
        "56": WeatherInfo(dayDescription: "Light Freezing Drizzle", nightDescription: "Light Freezing Drizzle", dayModel: "light_rain", nightModel: "light_rain", backgroundDay: LinearGradient(colors: [.yellow, .orange], startPoint: .top, endPoint: .bottom), backgroundNight: LinearGradient(colors: [.blue.opacity(0.7), .blue], startPoint: .top, endPoint: .bottom), colorDay: [.yellow, .orange], colorNight: [.indigo.opacity(0.7), .blue]),
        
        "57": WeatherInfo(dayDescription: "Freezing Drizzle", nightDescription: "Freezing Drizzle", dayModel: "snowfall", nightModel: "snowfall", backgroundDay: LinearGradient(colors: [.yellow, .orange], startPoint: .top, endPoint: .bottom), backgroundNight: LinearGradient(colors: [.indigo.opacity(0.7), .blue], startPoint: .top, endPoint: .bottom), colorDay: [.yellow, .orange], colorNight: [.indigo.opacity(0.7), .blue]),
        
        "61": WeatherInfo(dayDescription: "Light Rain", nightDescription: "Light Rain", dayModel: "light_rain", nightModel: "light_rain", backgroundDay: LinearGradient(colors: [.yellow, .orange], startPoint: .top, endPoint: .bottom), backgroundNight: LinearGradient(colors: [.indigo.opacity(0.7), .blue], startPoint: .top, endPoint: .bottom), colorDay: [.yellow, .orange], colorNight: [.indigo.opacity(0.7), .blue]),
        
        "63": WeatherInfo(dayDescription: "Rain", nightDescription: "Rain", dayModel: "light_rain", nightModel: "light_rain", backgroundDay: LinearGradient(colors: [.yellow, .orange], startPoint: .top, endPoint: .bottom), backgroundNight: LinearGradient(colors: [.indigo.opacity(0.7), .blue], startPoint: .top, endPoint: .bottom), colorDay: [.yellow, .orange], colorNight: [.indigo.opacity(0.7), .blue]),
             
        "65": WeatherInfo(dayDescription: "Heavy Rain", nightDescription: "Heavy Rain", dayModel: "heavy_rain", nightModel: "heavy_rain", backgroundDay: LinearGradient(colors: [.yellow, .orange], startPoint: .top, endPoint: .bottom), backgroundNight: LinearGradient(colors: [.indigo.opacity(0.7), .blue], startPoint: .top, endPoint: .bottom), colorDay: [.yellow, .orange], colorNight: [.indigo.opacity(0.7), .blue]),
             
        "66": WeatherInfo(dayDescription: "Light Freezing Rain", nightDescription: "Light Freezing Rain", dayModel: "snowfall", nightModel: "snowfall", backgroundDay: LinearGradient(colors: [.yellow, .orange], startPoint: .top, endPoint: .bottom), backgroundNight: LinearGradient(colors: [.indigo.opacity(0.7), .blue], startPoint: .top, endPoint: .bottom), colorDay: [.yellow, .orange], colorNight: [.indigo.opacity(0.7), .blue]),
             
        "67": WeatherInfo(dayDescription: "Freezing Rain", nightDescription: "Freezing Rain", dayModel: "snowfall", nightModel: "snowfall", backgroundDay: LinearGradient(colors: [.yellow, .orange], startPoint: .top, endPoint: .bottom), backgroundNight: LinearGradient(colors: [.indigo.opacity(0.7), .blue], startPoint: .top, endPoint: .bottom), colorDay: [.yellow, .orange], colorNight: [.indigo.opacity(0.7), .blue]),
             
        "71": WeatherInfo(dayDescription: "Light Snow", nightDescription: "Light Snow", dayModel: "snowfall", nightModel: "snowfall", backgroundDay: LinearGradient(colors: [.yellow, .orange], startPoint: .top, endPoint: .bottom), backgroundNight: LinearGradient(colors: [.indigo.opacity(0.7), .blue], startPoint: .top, endPoint: .bottom), colorDay: [.yellow, .orange], colorNight: [.indigo.opacity(0.7), .blue]),
             
        "73": WeatherInfo(dayDescription: "Snow", nightDescription: "Snow", dayModel: "heavy_snow", nightModel: "heavy_snow", backgroundDay: LinearGradient(colors: [.yellow, .orange], startPoint: .top, endPoint: .bottom), backgroundNight: LinearGradient(colors: [.indigo.opacity(0.7), .blue], startPoint: .top, endPoint: .bottom), colorDay: [.yellow, .orange], colorNight: [.indigo.opacity(0.7), .blue]),
             
        "75": WeatherInfo(dayDescription: "Heavy Snow", nightDescription: "Heavy Snow", dayModel: "heavy_snow", nightModel: "heavy_snow", backgroundDay: LinearGradient(colors: [.yellow, .orange], startPoint: .top, endPoint: .bottom), backgroundNight: LinearGradient(colors: [.indigo.opacity(0.7), .blue], startPoint: .top, endPoint: .bottom), colorDay: [.yellow, .orange], colorNight: [.indigo.opacity(0.7), .blue]),
             
        "77": WeatherInfo(dayDescription: "Snow Grains", nightDescription: "Snow Grains", dayModel: "snowfall", nightModel: "snowfall", backgroundDay: LinearGradient(colors: [.yellow, .orange], startPoint: .top, endPoint: .bottom), backgroundNight: LinearGradient(colors: [.indigo.opacity(0.7), .blue], startPoint: .top, endPoint: .bottom), colorDay: [.yellow, .orange], colorNight: [.indigo.opacity(0.7), .blue]),
 
        
        "80": WeatherInfo(dayDescription: "Light Showers", nightDescription: "Light Showers", dayModel: "light_rain", nightModel: "light_rain", backgroundDay: LinearGradient(colors: [.indigo.opacity(0.8), .indigo.opacity(0.4)], startPoint: .top, endPoint: .bottom), backgroundNight: LinearGradient(colors: [.indigo.opacity(0.7), .blue], startPoint: .top, endPoint: .bottom), colorDay: [.yellow, .orange], colorNight: [.indigo.opacity(0.7), .blue]),
                    
        "81": WeatherInfo(dayDescription: "Showers", nightDescription: "Showers", dayModel: "light_rain", nightModel: "light_rain", backgroundDay: LinearGradient(colors: [.yellow, .orange], startPoint: .top, endPoint: .bottom), backgroundNight: LinearGradient(colors: [.indigo.opacity(0.7), .blue], startPoint: .top, endPoint: .bottom), colorDay: [.yellow, .orange], colorNight: [.indigo.opacity(0.7), .blue]),
        
                    
        "82": WeatherInfo(dayDescription: "Heavy Showers", nightDescription: "Heavy Showers", dayModel: "heavy_rain", nightModel: "heavy_rain", backgroundDay: LinearGradient(colors: [.yellow, .orange], startPoint: .top, endPoint: .bottom), backgroundNight: LinearGradient(colors: [.indigo.opacity(0.7), .blue], startPoint: .top, endPoint: .bottom), colorDay: [.yellow, .orange], colorNight: [.indigo.opacity(0.7), .blue]),
        
                    
        "85": WeatherInfo(dayDescription: "Light Snow Showers", nightDescription: "Light Snow Showers", dayModel: "snowfall", nightModel: "snowfall", backgroundDay: LinearGradient(colors: [.yellow, .orange], startPoint: .top, endPoint: .bottom), backgroundNight: LinearGradient(colors: [.indigo.opacity(0.7), .blue], startPoint: .top, endPoint: .bottom), colorDay: [.yellow, .orange], colorNight: [.indigo.opacity(0.7), .blue]),
        
                    
        "86": WeatherInfo(dayDescription: "Snow Showers", nightDescription: "Snow Showers", dayModel: "snowfall", nightModel: "snowfall", backgroundDay: LinearGradient(colors: [.yellow, .orange], startPoint: .top, endPoint: .bottom), backgroundNight: LinearGradient(colors: [.indigo.opacity(0.7), .blue], startPoint: .top, endPoint: .bottom), colorDay: [.yellow, .orange], colorNight: [.indigo.opacity(0.7), .blue]),
        
                    
        "95": WeatherInfo(dayDescription: "Thunderstorm", nightDescription: "Thunderstorm", dayModel: "light_thunderstorm", nightModel: "light_thunderstorm", backgroundDay: LinearGradient(colors: [.yellow, .orange], startPoint: .top, endPoint: .bottom), backgroundNight: LinearGradient(colors: [.indigo.opacity(0.7), .blue], startPoint: .top, endPoint: .bottom), colorDay: [.yellow, .orange], colorNight: [.indigo.opacity(0.7), .blue]),
        
                         
        "96": WeatherInfo(dayDescription: "Light Thunderstorms With Hail", nightDescription: "Light Thunderstorms With Hail", dayModel: "thunderstorm_with_hail", nightModel: "thunderstorm_with_hail", backgroundDay: LinearGradient(colors: [.yellow, .orange], startPoint: .top, endPoint: .bottom), backgroundNight: LinearGradient(colors: [.indigo.opacity(0.7), .blue], startPoint: .top, endPoint: .bottom), colorDay: [.yellow, .orange], colorNight: [.indigo.opacity(0.7), .blue]),
        
                         
        "99": WeatherInfo(dayDescription: "Light Thunderstorms With Hail", nightDescription: "Light Thunderstorms With Hail", dayModel: "thunderstorm_with_hail", nightModel: "thunderstorm_with_hail", backgroundDay: LinearGradient(colors: [.yellow, .orange], startPoint: .top, endPoint: .bottom), backgroundNight: LinearGradient(colors: [.indigo.opacity(0.7), .blue], startPoint: .top, endPoint: .bottom), colorDay: [.yellow, .orange], colorNight: [.indigo.opacity(0.7), .blue]),
        
    
//        "0": WeatherInfo(dayDescription: "Sunny", nightDescription: "Clear", backgroundDay: "http://openweathermap.org/img/wn/01d@2x.png", backgroundNight: "http://openweathermap.org/img/wn/01n@2x.png"),
//        "1": WeatherInfo(dayDescription: "Mainly Sunny", nightDescription: "Mainly Clear", backgroundDay: "http://openweathermap.org/img/wn/01d@2x.png", backgroundNight: "http://openweathermap.org/img/wn/01n@2x.png"),
//        "2": WeatherInfo(dayDescription: "Partly Cloudy", nightDescription: "Partly Cloudy", backgroundDay: "http://openweathermap.org/img/wn/02d@2x.png", backgroundNight: "http://openweathermap.org/img/wn/02n@2x.png"),
//        "3": WeatherInfo(dayDescription: "Cloudy", nightDescription: "Cloudy", backgroundDay: "http://openweathermap.org/img/wn/03d@2x.png", backgroundNight: "http://openweathermap.org/img/wn/03n@2x.png"),
//        "45": WeatherInfo(dayDescription: "Foggy", nightDescription: "Foggy", backgroundDay: "http://openweathermap.org/img/wn/50d@2x.png", backgroundNight: "http://openweathermap.org/img/wn/50n@2x.png"),
//        "48": WeatherInfo(dayDescription: "Rime Fog", nightDescription: "Rime Fog", backgroundDay: "http://openweathermap.org/img/wn/50d@2x.png", backgroundNight: "http://openweathermap.org/img/wn/50n@2x.png"),
//        "51": WeatherInfo(dayDescription: "Light Drizzle", nightDescription: "Light Drizzle", backgroundDay: "http://openweathermap.org/img/wn/09d@2x.png", backgroundNight: "http://openweathermap.org/img/wn/09n@2x.png"),
//        "53": WeatherInfo(dayDescription: "Drizzle", nightDescription: "Drizzle", backgroundDay: "http://openweathermap.org/img/wn/09d@2x.png", backgroundNight: "http://openweathermap.org/img/wn/09n@2x.png"),
//        "55": WeatherInfo(dayDescription: "Heavy Drizzle", nightDescription: "Heavy Drizzle", backgroundDay: "http://openweathermap.org/img/wn/09d@2x.png", backgroundNight: "http://openweathermap.org/img/wn/09n@2x.png"),
//        "56": WeatherInfo(dayDescription: "Light Freezing Drizzle", nightDescription: "Light Freezing Drizzle", backgroundDay: "http://openweathermap.org/img/wn/09d@2x.png", backgroundNight: "http://openweathermap.org/img/wn/09n@2x.png"),
//        "57": WeatherInfo(dayDescription: "Freezing Drizzle", nightDescription: "Freezing Drizzle", backgroundDay: "http://openweathermap.org/img/wn/09d@2x.png", backgroundNight: "http://openweathermap.org/img/wn/09n@2x.png"),
//        "61": WeatherInfo(dayDescription: "Light Rain", nightDescription: "Light Rain", backgroundDay: "http://openweathermap.org/img/wn/10d@2x.png", backgroundNight: "http://openweathermap.org/img/wn/10n@2x.png"),
//        "63": WeatherInfo(dayDescription: "Rain", nightDescription: "Rain", backgroundDay: "http://openweathermap.org/img/wn/10d@2x.png", backgroundNight: "http://openweathermap.org/img/wn/10n@2x.png"),
//        "65": WeatherInfo(dayDescription: "Heavy Rain", nightDescription: "Heavy Rain", backgroundDay: "http://openweathermap.org/img/wn/10d@2x.png", backgroundNight: "http://openweathermap.org/img/wn/10n@2x.png"),
//        "66": WeatherInfo(dayDescription: "Light Freezing Rain", nightDescription: "Light Freezing Rain", backgroundDay: "http://openweathermap.org/img/wn/10d@2x.png", backgroundNight: "http://openweathermap.org/img/wn/10n@2x.png"),
//        "67": WeatherInfo(dayDescription: "Freezing Rain", nightDescription: "Freezing Rain", backgroundDay: "http://openweathermap.org/img/wn/10d@2x.png", backgroundNight: "http://openweathermap.org/img/wn/10n@2x.png"),
//        "71": WeatherInfo(dayDescription: "Light Snow", nightDescription: "Light Snow", backgroundDay: "http://openweathermap.org/img/wn/13d@2x.png", backgroundNight: "http://openweathermap.org/img/wn/13n@2x.png"),
//        "73": WeatherInfo(dayDescription: "Snow", nightDescription: "Snow", backgroundDay: "http://openweathermap.org/img/wn/13d@2x.png", backgroundNight: "http://openweathermap.org/img/wn/13n@2x.png"),
//        "75": WeatherInfo(dayDescription: "Heavy Snow", nightDescription: "Heavy Snow", backgroundDay: "http://openweathermap.org/img/wn/13d@2x.png", backgroundNight: "http://openweathermap.org/img/wn/13n@2x.png"),
//        "77": WeatherInfo(dayDescription: "Snow Grains", nightDescription: "Snow Grains", backgroundDay: "http://openweathermap.org/img/wn/13d@2x.png", backgroundNight: "http://openweathermap.org/img/wn/13n@2x.png"),
//        "80": WeatherInfo(dayDescription: "Light Showers", nightDescription: "Light Showers", backgroundDay: "http://openweathermap.org/img/wn/09d@2x.png", backgroundNight: "http://openweathermap.org/img/wn/09n@2x.png"),
//        "81": WeatherInfo(dayDescription: "Showers", nightDescription: "Showers", backgroundDay: "http://openweathermap.org/img/wn/09d@2x.png", backgroundNight: "http://openweathermap.org/img/wn/09n@2x.png"),
//        "82": WeatherInfo(dayDescription: "Heavy Showers", nightDescription: "Heavy Showers", backgroundDay: "http://openweathermap.org/img/wn/09d@2x.png", backgroundNight: "http://openweathermap.org/img/wn/09n@2x.png"),
//        "85": WeatherInfo(dayDescription: "Light Snow Showers", nightDescription: "Light Snow Showers", backgroundDay: "http://openweathermap.org/img/wn/13d@2x.png", backgroundNight: "http://openweathermap.org/img/wn/13n@2x.png"),
//        "86": WeatherInfo(dayDescription: "Snow Showers", nightDescription: "Snow Showers", backgroundDay: "http://openweathermap.org/img/wn/13d@2x.png", backgroundNight: "http://openweathermap.org/img/wn/13n@2x.png"),
//        "95": WeatherInfo(dayDescription: "Thunderstorm", nightDescription: "Thunderstorm", backgroundDay: "http://openweathermap.org/img/wn/11d@2x.png", backgroundNight: "http://openweathermap.org/img/wn/11n@2x.png"),
//        "96": WeatherInfo(dayDescription: "Light Thunderstorms With Hail", nightDescription: "Light Thunderstorms With Hail", backgroundDay: "http://openweathermap.org/img/wn/11d@2x.png", backgroundNight: "http://openweathermap.org/img/wn/11n@2x.png"),
//        "99": WeatherInfo(dayDescription: "Thunderstorm With Hail", nightDescription: "Thunderstorm With Hail", backgroundDay: "http://openweathermap.org/img/wn/11d@2x.png", backgroundNight: "http://openweathermap.org/img/wn/11n@2x.png")
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
            return weatherInfo!.backgroundNight
        } else {
            return weatherInfo!.backgroundDay
        }
    } else {
        return LinearGradient(
            gradient: Gradient(colors: [.purple.opacity(0.2), .indigo.opacity(0.8)]), startPoint: .top, endPoint: .bottom)
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
