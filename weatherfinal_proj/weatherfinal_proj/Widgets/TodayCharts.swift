//
//  TodayCharts.swift
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

struct TodayCharts: View {
    
    var hourly: HourlyData?
    @State private var rawSelectedTemperature: ClosedRange<Date>?
    var body: some View {
        let chartsData: [ChartHourData] = hourlyToChartsData(hourly: self.hourly)
        
        VStack(spacing: 2) {
            Text("Today temperatures")
            Chart {
                ForEach(chartsData, id: \.id) { chartHour in
                    LineMark(
//                        x: .value("Hour", "\(chartHour.time.suffix(5))"),
                        x: .value("Hour", chartHour.timeDate, unit: .hour),
                        y: .value("Temperature", chartHour.temperature)
                    )
                    .foregroundStyle(Color.blue.gradient)
//                                    .symbol {
//                                        Circle()
//                                            .fill(.indigo)
//                                            .frame(width: 5)
//                                    }
                    PointMark(
//                        x: .value("Hour", "\(chartHour.time.suffix(5))"),
                        x: .value("Hour", chartHour.timeDate, unit: .hour),
                        y: .value("Temperature", chartHour.temperature)
                    )
                    .foregroundStyle(.indigo)
                }
                
            }
            .frame(height: 300)
            .padding()
            .chartXAxis {
                AxisMarks(values: .automatic(desiredCount: 8)) { axisValue in
                    if let date = axisValue.as(Date.self) {
                        AxisValueLabel() {
                            let formatter = DateFormatter()
                            formatter.dateFormat = "HH:mm"
                            let formattedDate = formatter.string(from: date)
                            return Text("\(formattedDate)")
//                                .foregroundColor(Color.white)
                                .font(.system(size: 8))
                        }
                    }
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
                    
//                    AxisTick(stroke: StrokeStyle(lineWidth: 2))
                    
                    AxisGridLine(centered: false, stroke: StrokeStyle(lineWidth: 0.5, dash: [5]))
                }
            }
            //        .chartPlotStyle { plotContent in
            //                plotContent
            //                .background(.mint.gradient.opacity(0.1))
            //        }
        }
        .padding()
        .background(.ultraThinMaterial)
        .padding()
    }
}

#Preview {
    TodayCharts(
        hourly: HourlyData(time: ["2024-04-04T00:00", "2024-04-04T01:00", "2024-04-04T02:00", "2024-04-04T03:00", "2024-04-04T04:00", "2024-04-04T05:00", "2024-04-04T06:00", "2024-04-04T07:00", "2024-04-04T08:00", "2024-04-04T09:00",
                                  "2024-04-04T10:00", "2024-04-04T11:00", "2024-04-04T12:00", "2024-04-04T13:00", "2024-04-04T14:00",
                                  "2024-04-04T15:00", "2024-04-04T16:00", "2024-04-04T17:00", "2024-04-04T18:00", "2024-04-04T19:00",
                                  "2024-04-04T20:00", "2024-04-04T21:00", "2024-04-04T22:00", "2024-04-04T23:00",], temperature_2m: [13.0, 7.8, 13.3, 13.2, 25, 26.7, 28.1, 29.5, 30.2, 31.8, 32.5, 32.9, 33.2, 33.5, 33.8, 33.9, 33.6, 33.2, 32.8, 32.5, 32.2,
                                                                                                                                    32.0, 31.8, 31.5, 31.2, 30.9, 30.6, 30.3, 30.0], weather_code: [2, 61, 61, 61, 61, 61, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32], wind_speed_10m: [18.2, 17.3, 18.7, 17.2, 19, 20.1, 21.5, 22.3, 23.6, 24.9, 25.3, 25.8, 26.2, 26.5, 26.7, 26.8, 26.6, 26.3, 26.0, 25.7, 25.4,
                                                                                                                                                                                                                                                                                                                                         25.1, 24.8, 24.5, 24.2, 23.9, 23.6, 23.3, 23.0]))
}
