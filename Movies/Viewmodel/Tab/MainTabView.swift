//
//  MainTabView.swift
//  Movies
//
//  Created by Ali Gutierrez on 6/19/23.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var appLockVM: AppLockViewModel
    var body: some View {
        ZStack {
            if !appLockVM.isAppLockEnabled || appLockVM.isAppUnLocked {
                TabView {
                    MainView()
                        .tabItem {
                            Label("Shows", systemImage: "play.square.fill")
                        }
                    PeopleSearchView()
                        .tabItem {
                            Label("Search", systemImage: "magnifyingglass")
                        }
                    FavoritesView()
                        .tabItem {
                            Label("Favorites", systemImage: "bookmark.fill")
                        }
                    SettingsView()
                        .tabItem {
                            Label("Settings", systemImage: "gearshape.fill")
                        }
                }
            } else {
                AuthView()
            }
        }
        .onAppear {
            if appLockVM.isAppLockEnabled {
                appLockVM.appLockValidation()
            }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
