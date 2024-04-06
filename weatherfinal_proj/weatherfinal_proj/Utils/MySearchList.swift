//
//  MySearchList.swift
//  weatherAppV2proj
//
//  Created by Théo Ajavon on 02/04/2024.
//

import SwiftUI

struct MySearchList: View {
    var cities: [City]
    
    var body: some View {
        List(cities, id: \.id) { city in
            Button(action: {
                print(city.id)
            }) {
                HStack(spacing: 0) {
                    Image(systemName: "building.2")
                        .padding(.trailing, 16)
                    Text("**\(city.name)**")
                        + Text((city.admin1 != nil) ? " \(city.admin1!)" : "")
                        + Text((city.country != nil) ? ", \(city.country!)" : "")

                }
            }
            .foregroundStyle(.primary)
            .padding()
        }
//        .listStyle(.plain)
//        .background(.yellow)
//        .ignoresSafeArea(.all)
    }
}

#Preview {
    MySearchList(cities: [
        City(id: 1, name: "New York", latitude: 64, longitude: 53, elevation: 62, country: "USA", admin1: "NY"),
        City(id: 2, name: "Los Angeles", latitude: 34, longitude: 118, elevation: 71, country: "USA", admin1: "CA"),
        City(id: 3, name: "London", latitude: 51, longitude: -0.1, elevation: 35, country: "UK", admin1: nil),
        City(id: 4, name: "Paris", latitude: 48, longitude: 2, elevation: 35, country: "France", admin1: "île-de-france mon gaaaars"),
        City(id: 5, name: "Tokyo", latitude: 35, longitude: 139, elevation: 43, country: "Japan", admin1: nil),
        City(id: 6, name: "Sydney", latitude: -33.9, longitude: 151.2, elevation: 3, country: "Australia", admin1: "NSW"),
        City(id: 7, name: "Rio de Janeiro", latitude: -22.9, longitude: -43.2, elevation: 6, country: "Brazil", admin1: "RJ"),
        City(id: 8, name: "Mumbai", latitude: 19, longitude: 72.8, elevation: 14, country: "India", admin1: "MH"),
        City(id: 9, name: "Shanghai", latitude: 31, longitude: 121.5, elevation: 4, country: "China", admin1: nil),
        City(id: 10, name: "Moscow", latitude: 55.7, longitude: 37.6, elevation: 155, country: "Russia", admin1: nil),
        City(id: 11, name: "Berlin", latitude: 52.5, longitude: 13.4, elevation: 34, country: "Germany", admin1: nil),
        City(id: 12, name: "Rome", latitude: 41.9, longitude: 12.5, elevation: 21, country: "Italy", admin1: nil),
        City(id: 13, name: "Cairo", latitude: 30, longitude: 31.2, elevation: 23, country: "Egypt", admin1: nil),
        City(id: 14, name: "Mexico City", latitude: 19.4, longitude: -99.1, elevation: 2240, country: "Mexico", admin1: "CDMX"),
        City(id: 15, name: "Toronto", latitude: 43.7, longitude: -79.4, elevation: 76, country: "Canada", admin1: "ON"),
        City(id: 16, name: "São Paulo", latitude: -23.5, longitude: -46.6, elevation: 760, country: "Brazil", admin1: "SP"),
        City(id: 17, name: "Seoul", latitude: 37.5, longitude: 126.9, elevation: 38, country: "South Korea", admin1: nil),
        City(id: 18, name: "Madrid", latitude: 40.4, longitude: -3.7, elevation: 667, country: "Spain", admin1: nil),
        City(id: 19, name: "Bangkok", latitude: 13.7, longitude: 100.5, elevation: 2, country: "Thailand", admin1: nil),
        City(id: 20, name: "Istanbul", latitude: 41, longitude: 28.9, elevation: 39, country: "Turkey", admin1: nil)
    ])
}
