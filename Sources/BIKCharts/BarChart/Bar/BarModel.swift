//
//  BarModel.swift
//  Charts
//
//  Created by berdil karaçam on 12.03.2020.
//  Copyright © 2020 Berdil İlyada Karacam. All rights reserved.
//

import Foundation
import SwiftUI

struct BarModel {
    let value: CGFloat
    let valueName: String?
    let calculationStyle: BarChart.CalculationStyle
    let fillBarColor: Color
    let emptyBarColor: Color
    let barWidth: CGFloat
    let barHeight: CGFloat
    let barCornerRadius: CGFloat
    let descriptionLabelSize: CGFloat
    let showValueText: Bool
    let showValueDescription: Bool
    
    init(value: CGFloat, valueName: String?, calculationStyle: BarChart.CalculationStyle, fillBarColor: Color, emptyBarColor: Color, barWidth: CGFloat, barHeight: CGFloat, barCornerRadius: CGFloat, descriptionLabelSize: CGFloat, showValueText: Bool, showValueDescription: Bool) {
        self.showValueText = showValueText
        self.showValueDescription = showValueDescription
        self.value = value
        self.valueName = valueName
        self.calculationStyle = calculationStyle
        self.fillBarColor = fillBarColor
        self.emptyBarColor = emptyBarColor
        self.barWidth = barWidth
        self.barHeight = barHeight
        self.barCornerRadius = barCornerRadius
        self.descriptionLabelSize = descriptionLabelSize
    }
    
}
