//
//  AppLockViewModel.swift
//  Movies
//
//  Created by Ali Gutierrez on 6/20/23.
//

import Foundation
import LocalAuthentication

/// All App Lock related methods will be handled here
class AppLockViewModel: ObservableObject {
    /// Publishing the applock state from user defaults
    @Published var isAppLockEnabled: Bool = false
    /// Publishing if the app is curretly unlocked or not
    @Published var isAppUnLocked: Bool = false
    
    init() {
        getAppLockState()
    }
    
    /// To enable the AppLock in UserDefaults
    func enableAppLock() {
        serviceLocator.userDefaults.set(true, forKey: .isAppLockEnable)
        self.isAppLockEnabled = true
    }
    
    /// To disable the AppLock in UserDefaults
    func disableAppLock() {
        serviceLocator.userDefaults.set(false, forKey: .isAppLockEnable)
        self.isAppLockEnabled = false
    }

    func getAppLockState() {
        isAppLockEnabled = serviceLocator.userDefaults.object(forKey: .isAppLockEnable) as? Bool ?? false
    }

    func checkIfBioMetricAvailable() -> Bool {
        var error: NSError?
        let laContext = LAContext()
        
        let isBimetricAvailable = laContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
        if let error = error {
            print(error.localizedDescription)
        }
        
        return isBimetricAvailable
    }

    func appLockStateChange(appLockState: Bool) {
        let laContext = LAContext()
        if checkIfBioMetricAvailable() {
            var reason = ""
            if appLockState {
                reason = "Authenticate with Touch ID/Face ID to enable App Lock"
            } else {
                reason = "Authenticate with TTouch ID/Face ID to disable App Lock"
            }
            
            laContext.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { (success, error) in
                if success {
                    if appLockState {
                        DispatchQueue.main.async {
                            self.enableAppLock()
                            self.isAppUnLocked = true
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.disableAppLock()
                            self.isAppUnLocked = true
                        }
                    }
                } else {
                    if let error = error {
                        DispatchQueue.main.async {
                            print(error.localizedDescription)
                        }
                    }
                }
            }
        }
    }

    func appLockValidation() {
        let laContext = LAContext()
        if checkIfBioMetricAvailable() {
            let reason = "Authenticate with app to protect your data"
            laContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { (success, error) in
                if success {
                    DispatchQueue.main.async {
                        self.isAppUnLocked = true
                    }
                } else {
                    if let error = error {
                        DispatchQueue.main.async {
                            print(error.localizedDescription)
                        }
                    }
                }
            }
        }
    }
}

