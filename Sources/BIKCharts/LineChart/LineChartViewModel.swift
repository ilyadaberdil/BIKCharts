//
//  LineChartViewModel.swift
//  Charts
//
//  Created by Berdil İlyada Karacam on 28.07.2020.
//  Copyright © 2020 Berdil İlyada Karacam. All rights reserved.
//

import SwiftUI

final public class LineChartViewModel: ObservableObject {
    
    @Published var calculationStyle: CalculationStyle
    @Published var showPoints: Bool
    @Published var lineWidth: CGFloat
    @Published var lineColor : Color
    @Published var data: [CGFloat]
    @Published var fillWithLinearGradient: LinearGradient?
    @Published var showLineWhenFilled: Bool
    @Published var pointColor: Color
    @Published var dashOfLine: [CGFloat]
    
    public init(data: [CGFloat],
                calculationStyle: CalculationStyle,
                lineWidth: CGFloat,
                showPoints: Bool,
                lineColor: Color,
                pointColor: Color,
                fillWithLinearGradient: LinearGradient? = nil,
                showLineWhenFilled: Bool,
                dashOfLine: [CGFloat] = []) {
        self.data = data
        self.calculationStyle = calculationStyle
        self.lineWidth = lineWidth
        self.showPoints = showPoints
        self.lineColor = lineColor
        self.fillWithLinearGradient = fillWithLinearGradient
        self.showLineWhenFilled = showLineWhenFilled
        self.pointColor = pointColor
        self.dashOfLine = dashOfLine
    }
}
