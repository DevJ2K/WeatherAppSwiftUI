//
//  MiniSceneView.swift
//  weatherfinal_proj
//
//  Created by Théo Ajavon on 11/04/2024.
//

import SwiftUI
import SceneKit

struct MiniSceneView: UIViewRepresentable {
//    @Binding var scene: SCNScene?
    let sceneName: String
    let toBloomModel = ["crescent_moon", "stars_001", "stars_002", "stars_003", "stars_004", "moon_night"]
    
    func makeUIView(context: Context) -> SCNView {
        let view = SCNView()
        var scene = get3DModel(sceneName: sceneName)
        if (scene == nil) {
            scene = .init(named: "\(sceneName).scn")
            if (scene == nil) {
                view.backgroundColor = .clear
                return view
            }
        }
        
//        view.allowsCameraControl = true
        view.autoenablesDefaultLighting = true
        view.antialiasingMode = .multisampling2X
        view.scene = scene
        view.backgroundColor = .clear
        
        // Apply fade in effect


        for model in toBloomModel {
            view.scene?.rootNode.childNode(withName: model, recursively: true)?.filters = addBloom()
        }
        if let node = view.scene?.rootNode.childNode(withName: "Cylinder_039", recursively: true) {
            node.scale = SCNVector3(1, 1, 1)
            // Start loop animation
//            startLoopAnimation(node)
        }
        
        view.scene?.rootNode.childNode(withName: "crescent_moon", recursively: true)?.filters = addBloom()
        view.scene?.rootNode.childNode(withName: "Sphere_001", recursively: true)?.filters = addBloom()
        
        return view
        
    }
    
    func updateUIView(_ uiView: SCNView, context: Context) {
        
    }
    
    func addBloom() -> [CIFilter]? {
        let bloomFilter = CIFilter(name:"CIBloom")!
        bloomFilter.setValue(0.2, forKey: "inputIntensity")
        bloomFilter.setValue(5.0, forKey: "inputRadius")

        return [bloomFilter]
    }

}

#Preview {
//    return ContentView()
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
                "weather_code": 80,
                "wind_speed_10m": 18.9
            },
            "hourly": {
                "time": ["2024-04-04T00:00", "2024-04-04T01:00", "2024-04-04T02:00", "2024-04-04T03:00"],
                "temperature_2m": [13.0, 12.8, 13.3, 13.2],
                "weather_code": [2, 61, 61, 61],
                "wind_speed_10m": [18.2, 17.3, 18.7, 17.2],
                "sunrise": "2024-04-04T04:09",
                "sunset": "2024-04-04T18:09",
            },
            "daily": {
                "time": ["2024-04-04", "2024-04-05", "2024-04-06"],
                "weather_code": [80, 61, 3],
                "temperature_2m_max": [18.4, 17.2, 24.9],
                "temperature_2m_min": [12.0, 13.0, 12.1],
                "sunrise": ["2024-04-04T04:09"],
                "sunset": ["2024-04-04T18:09"],
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
            .background(LinearGradient(
                gradient: Gradient(colors: [.purple.opacity(0.2), .indigo.opacity(0.8)]), startPoint: .top, endPoint: .bottom))
    } catch {
        // Handle decoding error
        print("Error decoding JSON:", error)
        return Text("Invalid previews")
    }
}
