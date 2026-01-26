//
//  epahichanApp.swift
//  epahichan
//
//  Created by Nabin Shrestha on 1/20/26.
//

import SwiftUI

@main
struct epahichanApp: App {
    @AppStorage("isDarkMode") private var isDarkModeEnabled = false
    
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
                .preferredColorScheme(isDarkModeEnabled ? .dark : .light)
        }
    }
}
