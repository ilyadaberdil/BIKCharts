//
//  BarChartViewModel.swift
//  Charts
//
//  Created by berdil karaçam on 12.03.2020.
//  Copyright © 2020 Berdil İlyada Karacam. All rights reserved.
//

import Foundation
import SwiftUI

final public class BarChartViewModel: ObservableObject {
    @Published var data: [CGFloat]
    @Published var dataDescriptions: [String?]?
    @Published var calculationType: CalculationStyle
    @Published var barSpacing: CGFloat
    @Published var fillBarColor: Color
    @Published var emptyBarColor: Color
    @Published var barCornerRadius: CGFloat
    @Published var showValueText: Bool
    @Published var showValueDescription: Bool
    @Published var direction: BarChartDirection
    
    public init(data: [CGFloat], dataDescriptions: [String?]?, calculationType: CalculationStyle, barSpacing: CGFloat, fillBarColor: Color, emptyBarColor: Color, barCornerRadius: CGFloat, showValueText: Bool, showValueDescription: Bool, direction: BarChartDirection) {
        self.data = data
        self.dataDescriptions = dataDescriptions
        self.calculationType = calculationType
        self.barSpacing = barSpacing
        self.fillBarColor = fillBarColor
        self.emptyBarColor = emptyBarColor
        self.barCornerRadius = barCornerRadius
        self.showValueText = showValueText
        self.showValueDescription = showValueDescription
        self.direction = direction
    }
}

public enum BarChartDirection {
    case horizontal, vertical
}
