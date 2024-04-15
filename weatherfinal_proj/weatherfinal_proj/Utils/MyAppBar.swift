//
//  MyAppBar.swift
//  weatherAppV2proj
//
//  Created by Théo Ajavon on 29/03/2024.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case currently = "sun.max"
    case today = "clock"
    case weekly = "calendar"
}

struct MyAppBar: View {
    @Binding var selectedTab: Tab
    @Environment (\.colorScheme) var colorScheme
    //    private var fillImage: String {
    //        selectedTab.rawValue + ".fill"
    //    }
//    private var tabColor: Color {
//        switch selectedTab {
//        case .currently:
//            return colorScheme == .dark ? .blue : .indigo
//        case .today:
//            return colorScheme == .dark ? .green : Color(red: 0, green: 0.55, blue: 0)
//        case .weekly:
//            return colorScheme == .dark ? .yellow : Color(red: 240/255, green: 120/255, blue: 25/255)
//        }
//    }
    
//    private var tabName: String {
//        switch selectedTab {
//        case .currently:
//            return "Currently"
//        case .today:
//            return "Today"
//        case .weekly:
//            return "Weekly"
//        }
//    }
    
//    pri
    func getTabName(tab: Tab) -> String {
        switch tab {
        case .currently:
            return "Currently"
        case .today:
            return "Today"
        case .weekly:
            return "Weekly"
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    Spacer()
//                    if (selectedTab == tab) {
                        VStack(spacing: 6) {
                            Image(systemName: tab.rawValue)
                                .foregroundStyle(selectedTab == tab ? Color.white : .secondary)
                                .bold(selectedTab == tab)
                                .scaleEffect(1.25)
                                .font(.system(size: 16))
                                .onTapGesture {
//                                    withAnimation(.easeIn(duration: 0.2)) {
                                        selectedTab = tab
//                                    }
                                }
//                            print(tab.rawValue)
                            Text(getTabName(tab: tab))
                                .foregroundStyle(selectedTab == tab ? Color.white : .secondary)
                                .bold()
                                .font(.system(size: 12))
                        }
                        .frame(maxWidth: .infinity)
//                    }
//                    else {
//                        ZStack {
//                            Image(systemName: tab.rawValue)
//                                .foregroundStyle(.secondary)
//                                .bold(selectedTab == tab)
//                                .scaleEffect(1.25)
//                                .font(.system(size: 16))
//                                .onTapGesture {
////                                    withAnimation(.linear(duration: 0.2)) {
//                                        selectedTab = tab
////                                    }
//                                }
//                            Text(tabName)
//                                .opacity(0)
//                                .foregroundStyle(.secondary)
//                                .bold()
//                                .font(.system(size: 12))
//                            
//                        }
//                    }
                    
                    //                        .font(selectedTab == tab ? .headline : .subheadline)
                    Spacer()
                }
            }
        }
        .frame(width: nil, height: 70)
        .background(colorScheme == .dark ? .black.opacity(0.5) : .white.opacity(0.5))
//        .border(Color.red,  width: 1)
//        .overlay(Rectangle()
//            .fill(.black.opacity(0.1))
//            .frame(height: 1)
//            .shadow(color: Color.black.opacity(1), radius: 2, x: 0, y: -2)
                 
//                 , alignment: .top)
        //        .clipShape(RoundedRectangle(cornerRadius: 16))
//        .ignoresSafeArea(.all)
//        .padding()
    }
}
//
//#Preview {
//    ContentView()
//}

#Preview {
//    return ContentView()
    VStack {
        Spacer()
        MyAppBar(selectedTab: .constant(.currently))
        MyAppBar(selectedTab: .constant(.today))
        MyAppBar(selectedTab: .constant(.weekly))
//        Spacer()
    }
    .padding(.bottom, 16)
    .background(2/2 == 2/1
                ? LinearGradient(
                    gradient: Gradient(colors: [.purple.opacity(0.2), .indigo.opacity(0.8)]), startPoint: .top, endPoint: .bottom)
                : LinearGradient(
                    gradient: Gradient(colors: [.purple.opacity(0.7), .indigo.opacity(0.8)]), startPoint: .top, endPoint: .bottom))
    .ignoresSafeArea()
}
