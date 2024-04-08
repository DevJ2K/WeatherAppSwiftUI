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
    
    func makeUIView(context: Context) -> SCNView {
        let view = SCNView()
        view.allowsCameraControl = true
        view.autoenablesDefaultLighting = true
        view.antialiasingMode = .multisampling2X
        view.scene = .init(named: sceneName)
                view.backgroundColor = .clear
        
        // Apply fade in effect
        view.scene?.rootNode.opacity = 0
        let fadeInAction = SCNAction.fadeIn(duration: 3.5)
        view.scene?.rootNode.runAction(fadeInAction)


        
        //        let cameraNode = SCNNode()
        //        cameraNode.camera = SCNCamera()
        //        scene?.rootNode.addChildNode(cameraNode)
        //        view.pointOfView = cameraNode
        //
        //        cameraNode.position = SCNVector3(0, -1.55, 0)
        //        cameraNode.eulerAngles = SCNVector3(52, 0, 0)
        //
        //        SCNTransaction.begin()
        //        SCNTransaction.animationDuration = 5
        // Perform the initial scaling
//        print(scene?.rootNode.name ?? "HERE")
        if let node = view.scene?.rootNode.childNode(withName: "Cylinder_039", recursively: true) {
            node.scale = SCNVector3(1, 1, 1)
            // Start loop animation
//            startLoopAnimation(node)
        }
        
        view.scene?.rootNode.childNode(withName: "Sphere_001", recursively: true)?.filters = addBloom()
        
        //        cameraNode.position = SCNVector3(0, -1.05, 0)
        //        SCNTransaction.commit()
        
        return view
        
    }
    
    func updateUIView(_ uiView: SCNView, context: Context) {
        
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
    
    func addBloom() -> [CIFilter]? {
        let bloomFilter = CIFilter(name:"CIBloom")!
        bloomFilter.setValue(0.5, forKey: "inputIntensity")
        bloomFilter.setValue(20.0, forKey: "inputRadius")

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
                "weather_code": 80,
                "wind_speed_10m": 18.9
            },
            "hourly": {
                "time": ["2024-04-04T00:00", "2024-04-04T01:00", "2024-04-04T02:00", "2024-04-04T03:00"],
                "temperature_2m": [13.0, 12.8, 13.3, 13.2],
                "weather_code": [2, 61, 61, 61],
                "wind_speed_10m": [18.2, 17.3, 18.7, 17.2]
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
    } catch {
        // Handle decoding error
        print("Error decoding JSON:", error)
        return Text("Invalid previews")
    }
}