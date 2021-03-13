//
//  BadgeValueModel.swift
//  
//
//  Created by Berdil İlyada Karacam on 14.03.2021.
//

import SwiftUI

public struct BadgeValueModel {
    let title: String
    let showUnderline: Bool
    let underlineColor: Color
    let foregroundColor: Color
    
    public init(showUnderline: Bool = true, underlineColor: Color = .black, title: String = "Value", foregroundColor: Color = .red) {
        self.showUnderline = showUnderline
        self.underlineColor = underlineColor
        self.title = title
        self.foregroundColor = foregroundColor
    }
    
}
