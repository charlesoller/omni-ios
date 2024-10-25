//
//  ColorPalette.swift
//  Omni
//
//  Created by Charles Oller on 10/24/24.
//

import SwiftUI

enum ColorSchemeType {
    case light, dark
}

class ColorPalette {
    var backgroundColor: Color
    var backgroundSecondaryColor: Color
    var textColor: Color
    var secondaryTextColor: Color

    init(scheme: ColorSchemeType) {
        switch scheme {
        case .light:
            backgroundColor = Color.white
            backgroundSecondaryColor = Color.gray.opacity(0.2)
            textColor = Color.black
            secondaryTextColor = Color.gray
        case .dark:
            backgroundColor = Color.black
            backgroundSecondaryColor = Color.gray.opacity(0.8)
            textColor = Color.white
            secondaryTextColor = Color.gray.opacity(0.5)
        }
    }
}
