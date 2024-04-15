//
//  CustomSceneView.swift
//  weatherfinal_proj
//
//  Created by Théo Ajavon on 08/04/2024.
//

import SwiftUI
import SceneKit

struct CustomSceneView: UIViewRepresentable {
//    @Binding var scene: SCNScene?
    let sceneName: String
    let toBloomModel = ["crescent_moon", "stars_001", "stars_002", "stars_003", "stars_004", "moon_night"]
    
    let sunshine = ["Cylinder_001", "Cylinder_002", "Cylinder_003", "Cylinder_004", "Cylinder_005", "Cylinder_006", "Cylinder_007", "Cylinder_008", "Cylinder_009", "Cylinder_010", "Cylinder_011", "Cylinder_012"]
    
    func makeUIView(context: Context) -> SCNView {
        let view = SCNView()
//        print("MODEL : \(sceneName)")
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
        view.scene?.rootNode.opacity = 0.0
        if (sceneName == "sunny") {
            
            let fadeInAction = SCNAction.fadeOpacity(by: 0.2, duration: 0.5)
            view.scene?.rootNode.runAction(fadeInAction)
            for elt in sunshine {
                if let node = view.scene?.rootNode.childNode(withName: elt, recursively: true) {
                    node.filters = addBloom(intensity: 0.2, radius: 5.0)
                    scaleAnimation(node: node, from: 1.0, to: 0.8)
                }
            }
            if let sun = view.scene?.rootNode.childNode(withName: "Sphere_001", recursively: true) {
                sun.filters = addBloom(intensity: nil, radius: nil)
                scaleAnimation(node: sun, from: 1.05, to: 1.1)
            }
        } else {
            let fadeInAction = SCNAction.fadeOpacity(by: 1.0, duration: 1.0)
            view.scene?.rootNode.runAction(fadeInAction)
        }
    
        
        for model in toBloomModel {
            view.scene?.rootNode.childNode(withName: model, recursively: true)?.filters = addBloom(intensity: 0.1, radius: 6.0)
        }
        
        view.scene?.rootNode.childNode(withName: "crescent_moon", recursively: true)?.filters = addBloom(intensity: nil, radius: nil)
        
        return view
        
    }
    
    func updateUIView(_ uiView: SCNView, context: Context) {
        
    }
    
    private func scaleAnimation(node: SCNNode, from: Double, to: Double) {
        let scaleAction = SCNAction.scale(to: from, duration: 2)
        scaleAction.timingMode = .easeInEaseOut
        let reverseScaleAction = SCNAction.scale(to: to, duration: 2)
        reverseScaleAction.timingMode = .easeInEaseOut
        let disappearAndReverseScale = SCNAction.sequence([scaleAction, reverseScaleAction])
        let repeatAction = SCNAction.repeatForever(disappearAndReverseScale)
        node.runAction(repeatAction)
    }
    
    private func startLoopAnimation(_ node: SCNNode) {
        let appearAction = SCNAction.fadeIn(duration: 1)
        let scaleAction = SCNAction.scale(to: 1, duration: 1)
        scaleAction.timingMode = .easeInEaseOut
        let reverseScaleAction = SCNAction.scale(to: 0.8, duration: 1)
        reverseScaleAction.timingMode = .easeInEaseOut
        let disappearAction = SCNAction.fadeOut(duration: 1)
        
        let appearAndScale = SCNAction.group([appearAction, scaleAction])
        let disappearAndReverseScale = SCNAction.group([disappearAction, reverseScaleAction])
        
        let sequence = SCNAction.sequence([appearAndScale, SCNAction.wait(duration: 1), disappearAndReverseScale])
        let repeatAction = SCNAction.repeatForever(sequence)
        node.runAction(repeatAction)
    }
    
    func addBloom(intensity: Double?, radius: Double?) -> [CIFilter]? {
        let bloomFilter = CIFilter(name:"CIBloom")!
        bloomFilter.setValue(intensity ?? 0.5, forKey: "inputIntensity")
        bloomFilter.setValue(radius ?? 10.0, forKey: "inputRadius")

        return [bloomFilter]
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
        return CurrentlyView(cityInfo: cityInfo)
            .background(getRealBackground(cityInfo: cityInfo, weatherInfo: getWeatherInfo(weather_code: cityInfo.current?.weather_code), showSearchBar: false))
    } catch {
        // Handle decoding error
        print("Error decoding JSON:", error)
        return Text("Invalid previews")
    }
}
