//
//  SettingsView.swift
//  Movies
//
//  Created by Ali Gutierrez on 6/19/23.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var appLockVM: AppLockViewModel
   
    var body: some View {
        NavigationView {
            Form {
                Toggle(isOn: $appLockVM.isAppLockEnabled, label: {
                    Text("Use Authentication")
                })
                .onChange(of: appLockVM.isAppLockEnabled, perform: { value in
                    appLockVM.appLockStateChange(appLockState: value)
                })
            }
            .navigationTitle("Settings")
        }

    }
}
