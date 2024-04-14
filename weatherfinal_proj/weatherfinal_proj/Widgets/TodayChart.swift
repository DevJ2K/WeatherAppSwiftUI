//
//  TodayChart.swift
//  weatherfinal_proj
//
//  Created by Théo Ajavon on 09/04/2024.
//

import SwiftUI
import Charts


//"hourly": {
//    "time": ["2024-04-04T00:00", "2024-04-04T01:00", "2024-04-04T02:00", "2024-04-04T03:00"],
//    "temperature_2m": [13.0, 12.8, 13.3, 13.2],
//    "weather_code": [2, 61, 61, 61],
//    "wind_speed_10m": [18.2, 17.3, 18.7, 17.2]
//},

struct ChartHourData {
    var id = UUID()
    var time: String
    //    var hour: Int
    var timeDate: Date
    var temperature: Double
    var weather_code: Int8
    var wind_speed: Double
}

// Function to convert time strings to Hour objects
func convertToHours(timeString: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
    
    //    print(timeString)
    let date = dateFormatter.date(from: timeString)!
    //    print(date)
    //    print("++++")
    return date
}

func hourlyToChartsData(hourly: HourlyData?) -> [ChartHourData] {
    var chartDataArray: [ChartHourData] = []
    
    
    //    ForEach(0 ..< min(24, hourly!.time.count), id: \.self) { i in
    for i in 0 ..< min(24, hourly!.time.count) {
        let chartData = ChartHourData(time: hourly!.time[i], timeDate: convertToHours(timeString: hourly!.time[i]), temperature: hourly!.temperature_2m[i], weather_code: hourly!.weather_code[i], wind_speed: hourly!.wind_speed_10m[i])
        
        chartDataArray.append(chartData)
    }
    //    print(chartDataArray)
    return chartDataArray
}

struct TodayChart: View {
    
    var cityInfo: CityInfo?
    var hourly: HourlyData?
    @State private var rawSelectedTemperature: ClosedRange<Date>?
    var body: some View {
        let chartsData: [ChartHourData] = hourlyToChartsData(hourly: self.hourly)
        
        VStack(spacing: 2) {
            Text("Today temperatures")
                .font(.system(size: 16, weight: .light, design: .rounded))
                .opacity(0.7)
                .padding(.top)
            Chart {
                ForEach(chartsData, id: \.id) { chartHour in
                    LineMark(
                        x: .value("Hour", chartHour.timeDate),
                        y: .value("Temperature", chartHour.temperature)
                    )
                    .interpolationMethod(.catmullRom)
                    .foregroundStyle(Color.blue.gradient)
                    .symbol {
                        Circle()
                            .fill(.indigo)
                            .frame(width: 7)
                    }
                    
                    AreaMark(
                        x: .value("Hour", chartHour.timeDate),
                        y: .value("Temperature", chartHour.temperature)
                    )
                    .interpolationMethod(.catmullRom)
//                    .foregroundStyle(LinearGradient(colors: [.blue, .blue.opacity(0.7), .blue.opacity(0.05)], startPoint: .top, endPoint: .bottom))
                    .foregroundStyle(getRealBackground(cityInfo: cityInfo, weatherInfo: getWeatherInfo(weather_code: cityInfo?.current?.weather_code), showSearchBar: false))
                    .opacity(0.2)
                    
                    
                    
                }
                
            }
            .frame(height: 250)
            .chartXAxis {
                AxisMarks(preset: .aligned, values: .stride(by: .hour, count: 3)) { axisValue in
                    if let date = axisValue.as(Date.self) {
                        AxisValueLabel() {
                            let formatter = DateFormatter()
                            formatter.dateFormat = "HH:mm"
                            formatter.locale = Locale(identifier: "en_US_POSIX")
                            formatter.timeZone = TimeZone(secondsFromGMT: 0)
                            let formattedDate = formatter.string(from: date)
                            //                            print(axisValue.index)
                            if (axisValue.index == 8) {
                                return Text("")
                                    .font(.system(size: 8))
                            }
                            return Text("\(formattedDate)")
                            //                                .foregroundColor(Color.white)
                                .font(.system(size: 8))
                        }
                    }
                    AxisTick(stroke: StrokeStyle(lineWidth: 0))
                    AxisGridLine(centered: false, stroke: StrokeStyle(lineWidth: 0.5, dash: [2]))
                }
                
            }
            .chartYAxis {
                AxisMarks(position: .leading, values: .automatic(desiredCount: 8)) { value in
                    AxisValueLabel {
                        if let _temperature = value.as(Double.self) {
                            Text("\(_temperature.formatted())°C")
                        }
                    }
                    
                    AxisTick(stroke: StrokeStyle(lineWidth: 0))
                    
                    AxisGridLine(centered: false, stroke: StrokeStyle(lineWidth: 0.5, dash: [5]))
                }
            }
            .padding()
        }
        .background(Color.black.opacity(0.5))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding()
    }
}

#Preview {
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
                "weather_code": 1,
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
    
    
    
//    TodayChart(
//        hourly: HourlyData(time: ["2024-04-04T00:00", "2024-04-04T01:00", "2024-04-04T02:00", "2024-04-04T03:00", "2024-04-04T04:00", "2024-04-04T05:00", "2024-04-04T06:00", "2024-04-04T07:00", "2024-04-04T08:00", "2024-04-04T09:00",
//                                  "2024-04-04T10:00", "2024-04-04T11:00", "2024-04-04T12:00", "2024-04-04T13:00", "2024-04-04T14:00",
//                                  "2024-04-04T15:00", "2024-04-04T16:00", "2024-04-04T17:00", "2024-04-04T18:00", "2024-04-04T19:00",
//                                  "2024-04-04T20:00", "2024-04-04T21:00", "2024-04-04T22:00", "2024-04-04T23:00",], temperature_2m: [13.0, 7.8, 13.3, 13.2, 25, 26.7, 28.1, 29.5, 30.2, 31.8, 32.5, 32.9, 33.2, 33.5, 33.8, 33.9, 33.6, 33.2, 32.8, 32.5, 32.2,
//                                                                                                                                     32.0, 31.8, 31.5, 31.2, 30.9, 30.6, 30.3, 30.0], weather_code: [2, 61, 61, 61, 61, 61, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32], wind_speed_10m: [18.2, 17.3, 18.7, 17.2, 19, 20.1, 21.5, 22.3, 23.6, 24.9, 25.3, 25.8, 26.2, 26.5, 26.7, 26.8, 26.6, 26.3, 26.0, 25.7, 25.4,
//                                                                                                                                                                                                                                                                                                                                          25.1, 24.8, 24.5, 24.2, 23.9, 23.6, 23.3, 23.0]))
}
