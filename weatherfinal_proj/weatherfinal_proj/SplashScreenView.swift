//
//  SplashScreenView.swift
//  weatherfinal_proj
//
//  Created by Théo Ajavon on 12/04/2024.
//

import SwiftUI
import SceneKit

struct SplashScreenView: View {
    
    @State private var isActive = false
    private let loadingTime: Double = 2
    @State private var loadingState = 0.0
    var body: some View {
        if (isActive) {
            ContentView()
        } else {
            ZStack(alignment: .center) {
                LinearGradient(
                    gradient: Gradient(colors: [.purple.opacity(0.2), .indigo.opacity(0.8)]), startPoint: .top, endPoint: .bottom)
                VStack {
                    Text("Weather42")
                        .font(.system(size: 36, weight: .bold))
                        .italic()
                    CustomSceneView(sceneName: "cloudy_night")
                        .frame(height: 290)
                    //                    Image("icon")
                    //                        .resizable()
                    //                        .frame(width: 280, height: 280)
                    //                    Text("Weather42")
                    //                        .font(Font.custom("Baskerville-bold", size: 48))
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 16)
                            .frame(width: 210, height: 8)
                        //                            .opacity(0.4)
                        //                            .border(Color.indigo, width: 2)
                        RoundedRectangle(cornerRadius: 16)
                            .frame(width: loadingState, height: 8)
                            .foregroundStyle(.purple)
                    }
                    .onAppear {
                        while (loadingState < 210) {
                            withAnimation(.easeInOut(duration: loadingTime)) {
                                self.loadingState += 1
                            }
                        }
                    }
                }
            }
            .ignoresSafeArea(.all)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + loadingTime) {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        self.isActive = true
                    }
                }
            }
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [.purple.opacity(0.2), .indigo.opacity(0.8)]), startPoint: .top, endPoint: .bottom)
            )
        }
    }
}

#Preview {
    SplashScreenView()
}
