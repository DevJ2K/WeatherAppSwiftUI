//
//  City.swift
//  weatherAppV2proj
//
//  Created by Théo Ajavon on 01/04/2024.
//
//        https://geocoding-api.open-meteo.com/v1/search?name=&count=10&language=en&format=json

import Foundation


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
    let dayImageURL: String
    let nightImageURL: String
}

struct WeatherMap {
    static let data: [String: WeatherInfo] = [
        "0": WeatherInfo(dayDescription: "Sunny", nightDescription: "Clear", dayImageURL: "http://openweathermap.org/img/wn/01d@2x.png", nightImageURL: "http://openweathermap.org/img/wn/01n@2x.png"),
        "1": WeatherInfo(dayDescription: "Mainly Sunny", nightDescription: "Mainly Clear", dayImageURL: "http://openweathermap.org/img/wn/01d@2x.png", nightImageURL: "http://openweathermap.org/img/wn/01n@2x.png"),
        "2": WeatherInfo(dayDescription: "Partly Cloudy", nightDescription: "Partly Cloudy", dayImageURL: "http://openweathermap.org/img/wn/02d@2x.png", nightImageURL: "http://openweathermap.org/img/wn/02n@2x.png"),
        "3": WeatherInfo(dayDescription: "Cloudy", nightDescription: "Cloudy", dayImageURL: "http://openweathermap.org/img/wn/03d@2x.png", nightImageURL: "http://openweathermap.org/img/wn/03n@2x.png"),
        "45": WeatherInfo(dayDescription: "Foggy", nightDescription: "Foggy", dayImageURL: "http://openweathermap.org/img/wn/50d@2x.png", nightImageURL: "http://openweathermap.org/img/wn/50n@2x.png"),
        "48": WeatherInfo(dayDescription: "Rime Fog", nightDescription: "Rime Fog", dayImageURL: "http://openweathermap.org/img/wn/50d@2x.png", nightImageURL: "http://openweathermap.org/img/wn/50n@2x.png"),
        "51": WeatherInfo(dayDescription: "Light Drizzle", nightDescription: "Light Drizzle", dayImageURL: "http://openweathermap.org/img/wn/09d@2x.png", nightImageURL: "http://openweathermap.org/img/wn/09n@2x.png"),
        "53": WeatherInfo(dayDescription: "Drizzle", nightDescription: "Drizzle", dayImageURL: "http://openweathermap.org/img/wn/09d@2x.png", nightImageURL: "http://openweathermap.org/img/wn/09n@2x.png"),
        "55": WeatherInfo(dayDescription: "Heavy Drizzle", nightDescription: "Heavy Drizzle", dayImageURL: "http://openweathermap.org/img/wn/09d@2x.png", nightImageURL: "http://openweathermap.org/img/wn/09n@2x.png"),
        "56": WeatherInfo(dayDescription: "Light Freezing Drizzle", nightDescription: "Light Freezing Drizzle", dayImageURL: "http://openweathermap.org/img/wn/09d@2x.png", nightImageURL: "http://openweathermap.org/img/wn/09n@2x.png"),
        "57": WeatherInfo(dayDescription: "Freezing Drizzle", nightDescription: "Freezing Drizzle", dayImageURL: "http://openweathermap.org/img/wn/09d@2x.png", nightImageURL: "http://openweathermap.org/img/wn/09n@2x.png"),
        "61": WeatherInfo(dayDescription: "Light Rain", nightDescription: "Light Rain", dayImageURL: "http://openweathermap.org/img/wn/10d@2x.png", nightImageURL: "http://openweathermap.org/img/wn/10n@2x.png"),
        "63": WeatherInfo(dayDescription: "Rain", nightDescription: "Rain", dayImageURL: "http://openweathermap.org/img/wn/10d@2x.png", nightImageURL: "http://openweathermap.org/img/wn/10n@2x.png"),
        "65": WeatherInfo(dayDescription: "Heavy Rain", nightDescription: "Heavy Rain", dayImageURL: "http://openweathermap.org/img/wn/10d@2x.png", nightImageURL: "http://openweathermap.org/img/wn/10n@2x.png"),
        "66": WeatherInfo(dayDescription: "Light Freezing Rain", nightDescription: "Light Freezing Rain", dayImageURL: "http://openweathermap.org/img/wn/10d@2x.png", nightImageURL: "http://openweathermap.org/img/wn/10n@2x.png"),
        "67": WeatherInfo(dayDescription: "Freezing Rain", nightDescription: "Freezing Rain", dayImageURL: "http://openweathermap.org/img/wn/10d@2x.png", nightImageURL: "http://openweathermap.org/img/wn/10n@2x.png"),
        "71": WeatherInfo(dayDescription: "Light Snow", nightDescription: "Light Snow", dayImageURL: "http://openweathermap.org/img/wn/13d@2x.png", nightImageURL: "http://openweathermap.org/img/wn/13n@2x.png"),
        "73": WeatherInfo(dayDescription: "Snow", nightDescription: "Snow", dayImageURL: "http://openweathermap.org/img/wn/13d@2x.png", nightImageURL: "http://openweathermap.org/img/wn/13n@2x.png"),
        "75": WeatherInfo(dayDescription: "Heavy Snow", nightDescription: "Heavy Snow", dayImageURL: "http://openweathermap.org/img/wn/13d@2x.png", nightImageURL: "http://openweathermap.org/img/wn/13n@2x.png"),
        "77": WeatherInfo(dayDescription: "Snow Grains", nightDescription: "Snow Grains", dayImageURL: "http://openweathermap.org/img/wn/13d@2x.png", nightImageURL: "http://openweathermap.org/img/wn/13n@2x.png"),
        "80": WeatherInfo(dayDescription: "Light Showers", nightDescription: "Light Showers", dayImageURL: "http://openweathermap.org/img/wn/09d@2x.png", nightImageURL: "http://openweathermap.org/img/wn/09n@2x.png"),
        "81": WeatherInfo(dayDescription: "Showers", nightDescription: "Showers", dayImageURL: "http://openweathermap.org/img/wn/09d@2x.png", nightImageURL: "http://openweathermap.org/img/wn/09n@2x.png"),
        "82": WeatherInfo(dayDescription: "Heavy Showers", nightDescription: "Heavy Showers", dayImageURL: "http://openweathermap.org/img/wn/09d@2x.png", nightImageURL: "http://openweathermap.org/img/wn/09n@2x.png"),
        "85": WeatherInfo(dayDescription: "Light Snow Showers", nightDescription: "Light Snow Showers", dayImageURL: "http://openweathermap.org/img/wn/13d@2x.png", nightImageURL: "http://openweathermap.org/img/wn/13n@2x.png"),
        "86": WeatherInfo(dayDescription: "Snow Showers", nightDescription: "Snow Showers", dayImageURL: "http://openweathermap.org/img/wn/13d@2x.png", nightImageURL: "http://openweathermap.org/img/wn/13n@2x.png"),
        "95": WeatherInfo(dayDescription: "Thunderstorm", nightDescription: "Thunderstorm", dayImageURL: "http://openweathermap.org/img/wn/11d@2x.png", nightImageURL: "http://openweathermap.org/img/wn/11n@2x.png"),
        "96": WeatherInfo(dayDescription: "Light Thunderstorms With Hail", nightDescription: "Light Thunderstorms With Hail", dayImageURL: "http://openweathermap.org/img/wn/11d@2x.png", nightImageURL: "http://openweathermap.org/img/wn/11n@2x.png"),
        "99": WeatherInfo(dayDescription: "Thunderstorm With Hail", nightDescription: "Thunderstorm With Hail", dayImageURL: "http://openweathermap.org/img/wn/11d@2x.png", nightImageURL: "http://openweathermap.org/img/wn/11n@2x.png")
    ]
}

func getWeatherDescription(weather_code: Int8) -> WeatherInfo? {
    
    return (WeatherMap.data["\(weather_code)"] ?? nil)
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
    var urlString = "https://api.open-meteo.com/v1/forecast?latitude=\(city.latitude)&longitude=\(city.longitude)&current=temperature_2m,is_day,weather_code,wind_speed_10m&hourly=temperature_2m,weather_code,wind_speed_10m&daily=weather_code,temperature_2m_max,temperature_2m_min"
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
        LocationManager.shared.isFetchingCity = true
    }
    let urlString = "https://geocoding-api.open-meteo.com/v1/search?name=\(name)&count=5&language=en&format=json"
    print(urlString)
    // Create URL
    guard let url = URL(string: urlString) else {
        print("This request has failed please try with an other URL...")
        DispatchQueue.main.async {
            LocationManager.shared.isFetchingCity = false
        }
        return []
    }
    
    // Fetch data from the URL
    do {
        //        print("1")
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            print("Invalid status code != 200")
            LocationManager.shared.isFetchingCity = false
            return []
        }
        //        print("2")
        // decode the data
        let decodedResponse = try JSONDecoder().decode(CityResult.self, from: data)
        //        print("3")
        //        print(decodedResponse.results)
        DispatchQueue.main.async {
            LocationManager.shared.isFetchingCity = false
        }
        return decodedResponse.results
    } catch {
        print("Failed to fetch the data : \(error)")
        DispatchQueue.main.async {
            LocationManager.shared.isFetchingCity = false
        }
        return []
    }
}
