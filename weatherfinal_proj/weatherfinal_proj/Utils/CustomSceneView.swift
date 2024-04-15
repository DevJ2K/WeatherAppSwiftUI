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
        
        var rootOpacity = 1.0
        var opacityDuration = 1.0
        
//        view.allowsCameraControl = true
        view.autoenablesDefaultLighting = true
        view.antialiasingMode = .multisampling2X
        view.scene = scene
        view.backgroundColor = .clear
    
        // Apply fade in effect
        view.scene?.rootNode.opacity = 0.0
        if (sceneName == "sunny") {
            rootOpacity = 0.1
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
        } else if (sceneName == "clear_moon") {
            if let moon_node = view.scene?.rootNode.childNode(withName: "crescent_moon", recursively: true) {
                moon_node.scale.x = 0.12
                moon_node.scale.y = 0.12
                moon_node.scale.z = 0.12
//                print("HEREE")
                moon_node.filters = addBloom(intensity: 0.5, radius: 7.0)
                rotationAnimation(node: moon_node)
            }
        } else if (sceneName == "cloudy") {
            opacityDuration = 0.4
            rootOpacity = 0.8
            if let cloud_node = view.scene?.rootNode.childNode(withName: "clear_cloud", recursively: true) {
                scaleAnimation(node: cloud_node, from: 1.387, to: 1.45)
                cloud_node.filters = addBloom(intensity: 0.1, radius: 4.0)
            }
        } else if (sceneName == "cloudy_fog") {
            opacityDuration = 0.4
            rootOpacity = 0.2
            if let cloud_node = view.scene?.rootNode.childNode(withName: "clear_cloud", recursively: true) {
                scaleAnimation(node: cloud_node, from: 1.387, to: 1.45)
                cloud_node.filters = addBloom(intensity: 1, radius: 10.0)
            }
        }
        else if (sceneName == "cloudy_night") {
            opacityDuration = 0.4
            for elt in ["stars_001", "stars_002", "stars_003", "stars_004"] {
                if let node = view.scene?.rootNode.childNode(withName: elt, recursively: true) {
                    let nb = Int(elt.suffix(1))!
                    node.filters = addBloom(intensity: 0.2, radius: 5.0)
                    starAnimation(node: node, direction: ((nb % 2) != 0))
                }
            }
            if let moon_node = view.scene?.rootNode.childNode(withName: "moon_night", recursively: true) {
                moon_node.filters = addBloom(intensity: 0.3, radius: 5.0)
            }
            if let cloud_node = view.scene?.rootNode.childNode(withName: "night_cloud", recursively: true) {
                scaleAnimation(node: cloud_node, from: 0.965, to: 1.0)
                cloud_node.filters = addBloom(intensity: 0.1, radius: 5.0)
            }
        } else if (sceneName == "partly_cloudy") {
            if let sun_node = view.scene?.rootNode.childNode(withName: "clean_sun", recursively: true) {
                sun_node.opacity = 0.8
                sun_node.filters = addBloom(intensity: 0.3, radius: 5.0)
                scaleAnimation(node: sun_node, from: 1.194, to: 1.3)
            }
        } else if (sceneName == "solo_snow") {
            if let solo_snow = view.scene?.rootNode.childNode(withName: "snowfall_001", recursively: true) {
                solo_snow.scale.x = 0.55
                solo_snow.scale.y = 0.55
                solo_snow.scale.z = 0.55
                rotationAnimation(node: solo_snow)
                scaleAnimation(node: solo_snow, from: 0.5, to: 0.55)
            }
        } else if (sceneName == "light_rain") {
            for elt in ["raindrop_1", "raindrop_2", "raindrop_3", "raindrop_4"] {
                if let node = view.scene?.rootNode.childNode(withName: elt, recursively: true) {
//                    let nb = Int(elt.suffix(1))!
                    node.filters = addBloom(intensity: 0.2, radius: 3.0)
                    rainfallAnimation(node: node, speedIntervals: [1.5, 2.5])
//                    starAnimation(node: node, direction: false)
                }
            }
        } else if (sceneName == "angry_rain") {
            for elt in ["raindrop_1_001", "raindrop_2_001", "raindrop_3_001", "raindrop_4_001"] {
                if let node = view.scene?.rootNode.childNode(withName: elt, recursively: true) {
//                    let nb = Int(elt.suffix(1))!
                    node.filters = addBloom(intensity: 0.2, radius: 3.0)
                    rainfallAnimation(node: node, speedIntervals: [1.5, 2.5])
//                    starAnimation(node: node, direction: false)
                }
            }
        } else if (sceneName == "heavy_rain") {
            for elt in ["raindrop_1_001", "raindrop_2_001", "raindrop_3_001", "raindrop_4_001","raindrop_1_002", "raindrop_2_002", "raindrop_3_002", "raindrop_4_002"] {
                if let node = view.scene?.rootNode.childNode(withName: elt, recursively: true) {
//                    let nb = Int(elt.suffix(1))!
                    node.opacity = 0.1
                    node.filters = addBloom(intensity: 0.1, radius: 2.0)
                    rainfallAnimation(node: node, speedIntervals: [0.5, 1.0])
//                    starAnimation(node: node, direction: false)
                }
            }
        } else if (sceneName == "snowfall" || sceneName == "night_snowfall") {
            for elt in ["snowfall_005", "snowfall_006", "snowfall_007"] {
                if let node = view.scene?.rootNode.childNode(withName: elt, recursively: true) {
//                    let nb = Int(elt.suffix(1))!
                    node.filters = addBloom(intensity: 0.1, radius: 3.0)
                    snowfallAnimation(node: node, speedIntervals: [2.5, 4.5])
//                    starAnimation(node: node, direction: false)
                }
            }
        } else if (sceneName == "heavy_snow") {
            for elt in ["snowfall_004", "snowfall_005", "snowfall_006", "snowfall_007", "snowfall_008", "snowfall_009"] {
                if let node = view.scene?.rootNode.childNode(withName: elt, recursively: true) {
//                    let nb = Int(elt.suffix(1))!
                    node.filters = addBloom(intensity: 0.1, radius: 2.0)
                    snowfallAnimation(node: node, speedIntervals: [1, 1.5])
//                    starAnimation(node: node, direction: false)
                }
            }
        } else if (sceneName == "snowflake") {
            for elt in ["snowfall_001", "snowfall_002", "snowfall_003", "snowfall_004"] {
                if let node = view.scene?.rootNode.childNode(withName: elt, recursively: true) {
                    rotationAnimation(node: node)
                    scaleAnimation(node: node, from: Double(node.scale.x) - 0.05, to: Double(node.scale.x))
                    node.filters = addBloom(intensity: 0.1, radius: 3.0)
//                    snowfallAnimation(node: node, speedIntervals: [2.5, 4.5])
                }
            }
        } else if (sceneName == "thunderstorm") {
//            Lightning_003
            if let lightning = view.scene?.rootNode.childNode(withName: "Lightning_003", recursively: true) {
                lightning.opacity = 0.8
                lightning.filters = addBloom(intensity: 0.3, radius: 5.0)
                scaleAnimation(node: lightning, from: 0.036, to: 0.040)
            }
        } else if (sceneName == "thunderstorm_with_hail") {
//            Lightning_003
            if let lightning = view.scene?.rootNode.childNode(withName: "Lightning_002", recursively: true) {
                lightning.opacity = 0.8
                lightning.filters = addBloom(intensity: 0.3, radius: 5.0)
                scaleAnimation(node: lightning, from: 0.024, to: 0.030)
            }
            for elt in ["raindrop_1_002", "raindrop_2_002", "raindrop_3_002", "raindrop_4_002"] {
                if let node = view.scene?.rootNode.childNode(withName: elt, recursively: true) {
//                    let nb = Int(elt.suffix(1))!
                    node.filters = addBloom(intensity: 0.2, radius: 3.0)
                    rainfallAnimation(node: node, speedIntervals: [1.5, 2.5])
//                    starAnimation(node: node, direction: false)
                }
            }
        } else if (sceneName == "big_thunderstorm_with_hail") {
//            Lightning_003
            if let lightning = view.scene?.rootNode.childNode(withName: "Lightning_002", recursively: true) {
                lightning.opacity = 0.8
                lightning.filters = addBloom(intensity: 0.3, radius: 5.0)
                scaleAnimation(node: lightning, from: 0.024, to: 0.030)
            }
            for elt in ["raindrop_1_003", "raindrop_2_003", "raindrop_3_003", "raindrop_4_003","raindrop_1_002", "raindrop_2_002", "raindrop_3_002", "raindrop_4_002"] {
                if let node = view.scene?.rootNode.childNode(withName: elt, recursively: true) {
//                    let nb = Int(elt.suffix(1))!
                    node.opacity = 0.1
                    node.filters = addBloom(intensity: 0.1, radius: 2.0)
                    rainfallAnimation(node: node, speedIntervals: [0.5, 1.0])
//                    starAnimation(node: node, direction: false)
                }
            }
        }
        else {}
    
        let fadeInAction = SCNAction.fadeOpacity(by: rootOpacity, duration: opacityDuration)
        view.scene?.rootNode.runAction(fadeInAction)
        
        
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
    
    private func rotationAnimation(node: SCNNode) {
        let startAction = SCNAction.rotate(by: 1, around: SCNVector3(x: 0, y: 0, z: 1), duration: 4)
        startAction.timingMode = .linear
        let sequenceAction = SCNAction.sequence([startAction])
        let repeatAction = SCNAction.repeatForever(sequenceAction)
        node.runAction(repeatAction)

    }
    
    private func starAnimation(node: SCNNode, direction: Bool) {
        let startAction = SCNAction.rotate(by: 1, around: SCNVector3(x: 0, y: 0, z: direction ? 1 : -1), duration: 0.5)
        startAction.timingMode = .linear
        let sequenceAction = SCNAction.sequence([startAction])
        let repeatAction = SCNAction.repeatForever(sequenceAction)
        node.runAction(repeatAction)
    }
    
    private func rainfallAnimation(node: SCNNode, speedIntervals: [Double]) {
        let startAction = SCNAction.move(by: SCNVector3(-0.15, 0, -0.25), duration: Double.random(in: speedIntervals[0]..<speedIntervals[1]))
        let disappearAction = SCNAction.fadeOut(duration: Double.random(in: speedIntervals[0]..<speedIntervals[1]))
        startAction.timingMode = .linear

        let appearAction = SCNAction.fadeIn(duration: 0)
        let topRaindrop = SCNAction.move(to: SCNVector3(node.position.x, node.position.y, node.position.z), duration: 0)
        
        let dropAnimation = SCNAction.group([startAction, disappearAction])
        let restartAnim = SCNAction.group([appearAction, topRaindrop])
        
        let sequenceAction = SCNAction.sequence([dropAnimation, restartAnim])
        let repeatAction = SCNAction.repeatForever(sequenceAction)
        node.runAction(repeatAction)
    }
    
    private func snowfallAnimation(node: SCNNode, speedIntervals: [Double]) {
        let startAction = SCNAction.move(by: SCNVector3(-0.05, 0, -0.25), duration: Double.random(in: speedIntervals[0]..<speedIntervals[1]))
        let disappearAction = SCNAction.fadeOut(duration: Double.random(in: speedIntervals[0]..<speedIntervals[1]))
        startAction.timingMode = .linear

        let appearAction = SCNAction.fadeIn(duration: 0.1)
        let topRaindrop = SCNAction.move(to: SCNVector3(node.position.x, node.position.y, node.position.z), duration: 0)
        
        let dropAnimation = SCNAction.group([startAction, disappearAction])
        let restartAnim = SCNAction.group([appearAction, topRaindrop])
        
        let sequenceAction = SCNAction.sequence([dropAnimation, restartAnim])
        let repeatAction = SCNAction.repeatForever(sequenceAction)
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
                "is_day": 0,
                "weather_code": 99,
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
