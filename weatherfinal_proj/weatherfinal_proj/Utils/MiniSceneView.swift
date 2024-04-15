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
        
        if (sceneName == "sunny") {
            let fadeInAction = SCNAction.fadeOpacity(by: 0.2, duration: 0.5)
            view.scene?.rootNode.runAction(fadeInAction)
            for elt in ["Cylinder_001", "Cylinder_002", "Cylinder_003", "Cylinder_004", "Cylinder_005", "Cylinder_006", "Cylinder_007", "Cylinder_008", "Cylinder_009", "Cylinder_010", "Cylinder_011", "Cylinder_012"] {
                if let node = view.scene?.rootNode.childNode(withName: elt, recursively: true) {
                    node.filters = addBloom(intensity: 0.2, radius: 5.0)
                }
            }
            if let sun = view.scene?.rootNode.childNode(withName: "Sphere_001", recursively: true) {
                sun.filters = addBloom(intensity: nil, radius: nil)
            }
        } else if (sceneName == "clear_moon") {
            if let moon_node = view.scene?.rootNode.childNode(withName: "crescent_moon", recursively: true) {
                moon_node.scale.x = 0.12
                moon_node.scale.y = 0.12
                moon_node.scale.z = 0.12
//                print("HEREE")
                moon_node.filters = addBloom(intensity: 0.5, radius: 7.0)
            }
        } else if (sceneName == "cloudy") {
            if let cloud_node = view.scene?.rootNode.childNode(withName: "clear_cloud", recursively: true) {
                cloud_node.filters = addBloom(intensity: 0.1, radius: 4.0)
            }
        } else if (sceneName == "cloudy_fog") {
            if let cloud_node = view.scene?.rootNode.childNode(withName: "clear_cloud", recursively: true) {
                cloud_node.filters = addBloom(intensity: 1, radius: 10.0)
            }
        }
        else if (sceneName == "cloudy_night") {
            for elt in ["stars_001", "stars_002", "stars_003", "stars_004"] {
                if let node = view.scene?.rootNode.childNode(withName: elt, recursively: true) {
                    node.filters = addBloom(intensity: 0.2, radius: 5.0)
                }
            }
            if let moon_node = view.scene?.rootNode.childNode(withName: "moon_night", recursively: true) {
                moon_node.filters = addBloom(intensity: 0.3, radius: 5.0)
            }
            if let cloud_node = view.scene?.rootNode.childNode(withName: "night_cloud", recursively: true) {                cloud_node.filters = addBloom(intensity: 0.1, radius: 5.0)
            }
        } else if (sceneName == "partly_cloudy") {
            if let sun_node = view.scene?.rootNode.childNode(withName: "clean_sun", recursively: true) {
                sun_node.opacity = 0.8
                sun_node.filters = addBloom(intensity: 0.3, radius: 5.0)
            }
        } else if (sceneName == "solo_snow") {
            if let solo_snow = view.scene?.rootNode.childNode(withName: "snowfall_001", recursively: true) {
                solo_snow.scale.x = 0.55
                solo_snow.scale.y = 0.55
                solo_snow.scale.z = 0.55
            }
        } else if (sceneName == "light_rain") {
            for elt in ["raindrop_1", "raindrop_2", "raindrop_3", "raindrop_4"] {
                if let node = view.scene?.rootNode.childNode(withName: elt, recursively: true) {
                    node.filters = addBloom(intensity: 0.2, radius: 3.0)
                }
            }
        } else if (sceneName == "angry_rain") {
            for elt in ["raindrop_1_001", "raindrop_2_001", "raindrop_3_001", "raindrop_4_001"] {
                if let node = view.scene?.rootNode.childNode(withName: elt, recursively: true) {
                    node.filters = addBloom(intensity: 0.2, radius: 3.0)
                }
            }
        } else if (sceneName == "heavy_rain") {
            for elt in ["raindrop_1_001", "raindrop_2_001", "raindrop_3_001", "raindrop_4_001","raindrop_1_002", "raindrop_2_002", "raindrop_3_002", "raindrop_4_002"] {
                if let node = view.scene?.rootNode.childNode(withName: elt, recursively: true) {
                    node.opacity = 0.5
                    node.filters = addBloom(intensity: 0.1, radius: 2.0)
                }
            }
        } else if (sceneName == "snowfall" || sceneName == "night_snowfall") {
            for elt in ["snowfall_005", "snowfall_006", "snowfall_007"] {
                if let node = view.scene?.rootNode.childNode(withName: elt, recursively: true) {
                    node.filters = addBloom(intensity: 0.1, radius: 3.0)
                }
            }
        } else if (sceneName == "heavy_snow") {
            for elt in ["snowfall_004", "snowfall_005", "snowfall_006", "snowfall_007", "snowfall_008", "snowfall_009"] {
                if let node = view.scene?.rootNode.childNode(withName: elt, recursively: true) {
                    node.filters = addBloom(intensity: 0.1, radius: 2.0)
                }
            }
        } else if (sceneName == "snowflake") {
            for elt in ["snowfall_001", "snowfall_002", "snowfall_003", "snowfall_004"] {
                if let node = view.scene?.rootNode.childNode(withName: elt, recursively: true) {
                    node.filters = addBloom(intensity: 0.1, radius: 3.0)
                }
            }
        } else if (sceneName == "thunderstorm") {
//            Lightning_003
            if let lightning = view.scene?.rootNode.childNode(withName: "Lightning_003", recursively: true) {
                lightning.opacity = 0.8
                lightning.filters = addBloom(intensity: 0.3, radius: 5.0)
            }
        } else if (sceneName == "thunderstorm_with_hail") {
            if let lightning = view.scene?.rootNode.childNode(withName: "Lightning_002", recursively: true) {
                lightning.opacity = 0.8
                lightning.filters = addBloom(intensity: 0.3, radius: 5.0)
            }
            for elt in ["raindrop_1_002", "raindrop_2_002", "raindrop_3_002", "raindrop_4_002"] {
                if let node = view.scene?.rootNode.childNode(withName: elt, recursively: true) {
                    node.filters = addBloom(intensity: 0.2, radius: 3.0)
                }
            }
        } else if (sceneName == "big_thunderstorm_with_hail") {
//            Lightning_003
            if let lightning = view.scene?.rootNode.childNode(withName: "Lightning_002", recursively: true) {
                lightning.opacity = 0.8
                lightning.filters = addBloom(intensity: 0.3, radius: 5.0)
            }
            for elt in ["raindrop_1_003", "raindrop_2_003", "raindrop_3_003", "raindrop_4_003","raindrop_1_002", "raindrop_2_002", "raindrop_3_002", "raindrop_4_002"] {
                if let node = view.scene?.rootNode.childNode(withName: elt, recursively: true) {
                    node.opacity = 0.1
                    node.filters = addBloom(intensity: 0.1, radius: 2.0)
                }
            }
        }
        else {}
        return view
        
    }
    
    func updateUIView(_ uiView: SCNView, context: Context) {
        
    }
    
    func addBloom(intensity: Double?, radius: Double?) -> [CIFilter]? {
        let bloomFilter = CIFilter(name:"CIBloom")!
        bloomFilter.setValue(intensity ?? 0.5, forKey: "inputIntensity")
        bloomFilter.setValue(radius ?? 10.0, forKey: "inputRadius")

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
                "weather_code": [2, 1, 61, 61],
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
