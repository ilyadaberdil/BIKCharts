//
//  PieSliceModel.swift
//  Charts
//
//  Created by Berdil İlyada Karacam on 1.08.2020.
//  Copyright © 2020 Berdil İlyada Karacam. All rights reserved.
//

import SwiftUI

struct PieSliceModel {
    let pieShapeModel: PieShapeModel
    let color: Color
    let textPosition: CGPoint
    let titleConfiguration: TitleConfiguration
    
    init(pieShapeModel: PieShapeModel,
         color: Color,
         textPosition: CGPoint = .zero,
         titleConfiguration: TitleConfiguration = TitleConfiguration()) {
        self.pieShapeModel = pieShapeModel
        self.color = color
        self.textPosition = textPosition
        self.titleConfiguration = titleConfiguration
    }
}

public struct TitleConfiguration {
    let title: String
    let foregroundColor: Color
    let font: Font
    
    public init(title: String = "", foregroundColor: Color = .white, font: Font = .headline) {
        self.title = title
        self.foregroundColor = foregroundColor
        self.font = font
    }
}
