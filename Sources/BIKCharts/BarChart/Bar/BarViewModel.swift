//
//  BarViewModel.swift
//  Charts
//
//  Created by berdil karaçam on 12.03.2020.
//  Copyright © 2020 Berdil İlyada Karacam. All rights reserved.
//

import Foundation
import SwiftUI

struct BarViewModel {
    var value: CGFloat
    var valueName: String?
    var calculationStyle: BarChart.CalculationStyle
    var fillBarColor: Color
    var emptyBarColor: Color
    var barWidth: CGFloat
    var barHeight: CGFloat
    var barCornerRadius: CGFloat
    var descriptionLabelSize: CGFloat
    var showValueText: Bool
    var showValueDescription: Bool
    
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
