//
//  ContentView.swift
//  weatherAppV2proj
//
//  Created by Théo Ajavon on 29/03/2024.
//

import SwiftUI




struct ContentView: View {
    @State private var cities = [City]()
    @State private var searchText = ""
    @State private var showSearchBar = false
    @State private var noAnimationDisplay = false
    @FocusState private var focusedSearch: Bool?
    @State private var selectedTab: Tab = .currently
    @Environment (\.colorScheme) var colorScheme
    @ObservedObject var locationManager = LocationManager.shared
    
    private var tabName: String {
        switch selectedTab {
        case .currently:
            return "Currently"
        case .today:
            return "Today"
        case .weekly:
            return "Weekly"
        }
    }
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func cancelSearchLocation() -> Void {
        hideKeyboard()
        // Wait for the keyboard to hide before performing animation
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
        noAnimationDisplay = false
        withAnimation(.easeInOut(duration: 0.2)) {
            showSearchBar = false
        }
        focusedSearch = false
        //        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // HEADER
            HStack {
                // TITLE
                if (showSearchBar == false) {
                    Text(tabName)
                        .fontWeight(.bold)
                        .font(.largeTitle)
                        .foregroundStyle(colorScheme == .dark ? .white : .black)
                    Spacer()
                }
                
                // LOC SEARCH
                HStack {
                    if (showSearchBar) { // The search bar
                        Image(systemName: "magnifyingglass")
                        TextField("Search", text: $searchText)
                            .focused($focusedSearch, equals: true)
                            .onSubmit {
                                hideKeyboard()
                            }
                            .onChange(of: searchText) { newValue in
                                if (searchText.isEmpty == false) {
                                    Task {
                                        
                                        let fetchedCities = await fetchCity(name: searchText)
                                        DispatchQueue.main.async {
                                            cities = fetchedCities
                                        }
                                    }
                                    
                                } else {
                                    DispatchQueue.main.async {
                                        cities = []
                                    }
                                }
                            }
                        Button(action: {
                            if (searchText.isEmpty == false) {
                                searchText = ""
                            } else {
                                cancelSearchLocation()
                            }
                        }, label: {
                            if (searchText.isEmpty == false) {
                                
                                Image(systemName: "xmark")
                                    .foregroundStyle(colorScheme == .dark ? .white : .black)
                            } else {
                                Text("Cancel")
                                    .font(.subheadline)
                                    .foregroundStyle(colorScheme == .dark ? .white : .black)
                            }
                        })
                    } else {
                        
                        HStack {
                            Button(action: {
                                noAnimationDisplay = true
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    searchText = ""
                                    showSearchBar = true
                                    focusedSearch = true
                                }
                            }, label: {
                                Image(systemName: "magnifyingglass")
                                    .foregroundStyle(colorScheme == .dark ? .white : .black)
                                    .padding(10)
                                    .bold()
                            })
                            Button(action: {
                                locationManager.requestLocation()
                                if (locationManager.cityLocation != nil) {
                                    print("Geolocation pressed and cityLocation exist !")
                                    Task {
                                        let cityInfoFetching = await fetchCityInfo(city: locationManager.cityLocation!)
                                        locationManager.cityInfo = cityInfoFetching
                                    }
                                } else {
                                    
                                    print("Geolocation pressed but cityLocation not exist !")
                                }
                            }, label: {
                                Image(systemName: "location")
                                    .foregroundStyle(colorScheme == .dark ? .white : .black)
                                    .padding(10)
                                    .bold()
                            })
                        }
                    }
                }
                .padding(showSearchBar ? 10 : 0)
                .background(.thinMaterial)
                .cornerRadius(20)
            }
            .padding(.top, 15)
            .padding(.horizontal)
            .padding(.bottom, 12)
            .background(noAnimationDisplay ? Color.primary.opacity(colorScheme == .dark ? 0.1 : 0.25) : Color.clear)
            
            
            if (noAnimationDisplay) {
                if (searchText.isEmpty || searchText.count == 1) {
                    VStack {
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(colorScheme == .dark ? .black : .white)
                    .ignoresSafeArea(.all)
                } else if (cities.count == 0 && searchText.count > 1 && LocationManager.shared.isFetchingCity == false) {
                    VStack(spacing: 12) {
                        Spacer()
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(.gray)
                            .font(.system(size: 48))
                        VStack(spacing: 2) {
                            Text("**No Results**")
                                .font(.title2)
                            Text("No results found for \"\(searchText)\".")
                                .foregroundStyle(.gray)
                                .font(.subheadline)
                        }
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(colorScheme == .dark ? .black : .white)
                } else {
                    List(cities, id: \.id) { city in
                        Button(action: {
                            print("\(city.id) : \(city.longitude) | \(city.latitude)")
                            searchText = ""
                            
                            locationManager.cityLocation = city
                            if (locationManager.cityLocation != nil) {
                                Task {
                                    let cityInfoFetching = await fetchCityInfo(city: locationManager.cityLocation!)
                                    locationManager.cityInfo = cityInfoFetching
//                                    DispatchQueue.main.async {
//                                        self.cityInfo = cityInfoFetching
//                                    }
                                }
                                
                            } else {
                                print("Invalid City")
                            }
                            focusedSearch = false
                            hideKeyboard()
                            noAnimationDisplay = false
                            withAnimation(.easeInOut(duration: 0.2)) {
                                showSearchBar = false
                            }
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
                    }
                }
            } else {
                TabView(selection: $selectedTab) {
                    if (locationManager.cityLocation != nil && locationManager.cityInfo != nil) {
                        CurrentlyView(cityInfo: locationManager.cityInfo)
                            .navigationTitle("Currently")
                            .tabItem {
                                VStack {
                                    Image(systemName: "sun.min")
                                    Text("Currently")
                                    
                                }
                            }
                            .tag(Tab.currently)
                    } else {
                        if (locationManager.cityLocation == nil) {
                            Text("Geolocation is not available, please enable it in your App settings.")
                                .multilineTextAlignment(.center)
                                .padding()
                                .tag(Tab.currently)
                        } else if (locationManager.cityInfo == nil) {
                            Text("The service connection is lost, please check your internet connection or try again later")
                                .multilineTextAlignment(.center)
                                .padding()
                                .tag(Tab.currently)
                        } else {
                            Text("Internal error, please try again.")
                                .multilineTextAlignment(.center)
                                .tag(Tab.currently)
                        }
                    }
                    if (locationManager.cityLocation != nil && locationManager.cityInfo != nil) {
                        TodayView(cityInfo: locationManager.cityInfo)
                            .tabItem {
                                VStack {
                                    Image(systemName: "calendar.day.timeline.left")
                                    Text("Today")
                                }
                            }
                            .tag(Tab.today)
                    } else {
                        if (locationManager.cityLocation == nil) {
                            Text("Geolocation is not available, please enable it in your App settings.")
                                .multilineTextAlignment(.center)
                                .padding()
                                .tag(Tab.today)
                        } else if (locationManager.cityInfo == nil) {
                            Text("The service connection is lost, please check your internet connection or try again later")
                                .multilineTextAlignment(.center)
                                .padding()
                                .tag(Tab.today)
                        } else {
                            Text("Internal error, please try again.")
                                .multilineTextAlignment(.center)
                                .tag(Tab.today)
                        }
                    }
                    if (locationManager.cityLocation != nil && locationManager.cityInfo != nil) {
                        WeeklyView(cityInfo: locationManager.cityInfo)
                            .tabItem {
                                VStack {
                                    Image(systemName: "calendar")
                                    Text("Weekly")
                                }
                            }
                            .tag(Tab.weekly)
                    } else {
                        if (locationManager.cityLocation == nil) {
                            Text("Geolocation is not available, please enable it in your App settings.")
                                .multilineTextAlignment(.center)
                                .padding()
                                .tag(Tab.weekly)
                        } else if (locationManager.cityInfo == nil) {
                            Text("The service connection is lost, please check your internet connection or try again later")
                                .multilineTextAlignment(.center)
                                .padding()
                                .tag(Tab.weekly)
                        } else {
                            Text("Internal error, please try again.")
                                .multilineTextAlignment(.center)
                                .tag(Tab.weekly)
                        }
                    }
                }
                .animation(nil, value: selectedTab)
                .searchable(text: $searchText)
                //                .overlay(alignment: .bottom) {
                //                    MyAppBar(selectedTab: $selectedTab)
                //                }
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
            MyAppBar(selectedTab: $selectedTab)
            //                .ignoresSafeArea(.all)
        }
        .padding(.bottom, 20)
        .background(showSearchBar ?
                    LinearGradient(colors: [colorScheme == .dark ? .black : .white], startPoint: .center, endPoint: .center) :
                        LinearGradient(
                            gradient: Gradient(colors: [.purple.opacity(colorScheme == .dark ? 0.2 : 0.7), .indigo.opacity(0.8)]), startPoint: .top, endPoint: .bottom))
        //        .ignoresSafeArea(edges: noAnimationDisplay ? [] : .bottom)
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    ContentView()
}
