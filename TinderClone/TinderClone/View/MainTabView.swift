//
//  MainTabView.swift
//  TinderClone
//
//  Created by Vedat Dokuzkardeş on 30.12.2023.
//

import SwiftUI

struct MainTabView: View {
    
    let user: User
    @State private var selectedIndex = 0
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        TabView(selection: $selectedIndex) {
            SwipeView()
                .onAppear{
                    selectedIndex = 0
                }
                .tabItem {
                    Image(systemName: "flame")
                }
                .tag(0)
            MatchView()
                .onAppear{
                    selectedIndex = 1
                }
                .tabItem {
                    Image(systemName: "bubble.right")
                }
                .tag(1)
            ProfileView(user: user, editMode: true)
                .onAppear{
                    selectedIndex = 2
                }
                .tabItem {
                    Image(systemName: "person")
                }
                .tag(2)
        }
        .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
        .background(colorScheme == .dark ? Color.black : Color.white)
    }
}

#Preview {
    MainTabView(user: User.mockUsers[0])
}
