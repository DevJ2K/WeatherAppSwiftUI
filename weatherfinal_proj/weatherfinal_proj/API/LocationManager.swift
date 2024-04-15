//
//  LocationManager.swift
//  weatherAppV2proj
//
//  Created by Théo Ajavon on 01/04/2024.
//

import Foundation
import CoreLocation
import CoreLocationUI

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    //    @Published var location: CLLocationCoordinate2D?
    @Published var cityLocation: City?
    @Published var cityInfo: CityInfo?
    
    @Published var isFetchingCityList = false
    
    @Published var isFetchingCityInfo = false
    
    private var userLocStatus: CLAuthorizationStatus?
    
    static let shared = LocationManager()
    
    private var locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    // Requests the one-time delivery of the user’s current location.
    //    func requestAllowOnceLocationPermission() {
    //        locationManager.requestLocation()
    //    }
    
    func requestLocation() {
        locationManager.requestWhenInUseAuthorization()
//        print("Geolocation : \(userLocStatus.debugDescription)")
        if (userLocStatus != nil) {
            if (userLocStatus == .authorizedWhenInUse || userLocStatus == .authorizedAlways) {
                locationManager.startUpdatingLocation()
            } else {
                cityLocation = nil
                cityInfo = nil
            }
        }
    }
    
    func updateCity(city: City) async {
        DispatchQueue.main.async {
            self.cityLocation = city
        }
        if (cityLocation != nil) {
            let cityInfoFetching = await fetchCityInfo(city: cityLocation!)
            DispatchQueue.main.async {
                self.cityInfo = cityInfoFetching
            }
            
        } else {
            print("Invalid City")
        }
    }
    
    func getPlace(for location: CLLocation,
                  completion: @escaping (CLPlacemark?) -> Void) {
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            
            guard error == nil else {
                print("*** Error in \(#function): \(error!.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let placemark = placemarks?[0] else {
                print("*** Error in \(#function): placemark is nil")
                completion(nil)
                return
            }
            
            completion(placemark)
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        userLocStatus = status
        switch status {
        case .notDetermined:
            print("DEBUG : Not determined")
        case .restricted:
            print("DEBUG : Restricted")
        case .denied:
            print("DEBUG : Denied")
        case .authorizedAlways:
            locationManager.startUpdatingLocation()
            print("DEBUG : Auth always")
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            print("DEBUG : Auth when in use")
        case .authorized:
            locationManager.startUpdatingLocation()
            print("DEBUG : One time")
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        DispatchQueue.main.async {
            self.isFetchingCityInfo = true
        }
//        print("STARTING FILL USER LOCATION !")
        guard let latestLocation = locations.first else { return }
        locationManager.stopUpdatingLocation()
        
        
        self.cityLocation = City(id: 1, name: "", latitude: latestLocation.coordinate.latitude, longitude: latestLocation.coordinate.longitude)
        
        Task {
            getPlace(for: latestLocation) { placemark in
                guard let placemark = placemark else { return }
                if let cityName = placemark.locality {
                    self.cityLocation?.name = cityName
                }
                
                if let country = placemark.country {
                    self.cityLocation?.country = country
                }
                
                if let state = placemark.administrativeArea {
                    self.cityLocation?.admin1 = state
                }
                
                if let cityTimezone = placemark.timeZone {
                    self.cityLocation?.timezone = cityTimezone.identifier
                }
//                print(placemark.country! + " | " + placemark.administrativeArea! + " | " + placemark.locality! + " | " + placemark.timeZone!.identifier)
//                print("ENDING FETCHING REAL POS INFO :")
                
                Task {
                    let fetchedCityInfo = await fetchCityInfo(city: self.cityLocation!)
                    DispatchQueue.main.async {
                        self.cityInfo = fetchedCityInfo
                        self.isFetchingCityInfo = false
//                        print(self.cityLocation ?? "cityLocation nil")
//                        print(self.cityInfo ?? "cityInfo nil")
                    }
                }
//                print("========================================")
            }
        }
//        print("ENDING FILL USER LOCATION !")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("Error of location : \(error.localizedDescription)")
    }
}
