//
//  AuthView.swift
//  Movies
//
//  Created by Ali Gutierrez on 6/20/23.
//

import SwiftUI

struct AuthView: View {
    @EnvironmentObject var appLockVM: AppLockViewModel
   
    var body: some View {
        VStack(spacing: 30) {
            Image(systemName: "lock.circle")
                .resizable()
                .frame(width: 100, height: 100, alignment: .center)
                .foregroundColor(.red)
            
            Text("App Locked")
                .font(.title)
                .foregroundColor(.red)
            
            Button("Authenticte") {
                appLockVM.appLockValidation()
            }
            .foregroundColor(.primary)
            .padding(.horizontal, 30)
            .padding(.vertical, 15)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.red)
                
            )
            Spacer(minLength: 0)
        }.padding(.top, 50)
    }
}

