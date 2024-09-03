//
//  Color.swift
//  CryptoApp
//
//  Created by Sahana  Rao on 13/08/24.
//

import Foundation
import SwiftUI

extension Color {
    
    static let theme = ColorTheme()
    static let launchTheme = LaunchTheme()
    
}
struct ColorTheme {
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let green = Color("GreenColor")
    let red = Color("RedColor")
    let secondaryText = Color("SecondaryTextColor")
}

struct LaunchTheme {
    
    let accent = Color("LaunchAccentColor")
    let baackground = Color("LaunchBackgroundColor")
}
