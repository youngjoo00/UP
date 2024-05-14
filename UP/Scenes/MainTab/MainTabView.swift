//
//  ContentView.swift
//  UP
//
//  Created by youngjoo on 5/13/24.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            MarketCoinView()
                .tabItem {
                    Image(systemName: "house")
                    Text("홈")
                }
            
            MyProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("프로필")
                }
        }
        .tint(.point)
    }
}

#Preview {
    MainTabView()
}
