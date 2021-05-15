//
//  LineChartModel.swift
//  Charts
//
//  Created by Berdil İlyada Karacam on 28.07.2020.
//  Copyright © 2020 Berdil İlyada Karacam. All rights reserved.
//

import SwiftUI

final public class LineChartModel: ObservableObject, Identifiable {
    
    @Published public var calculationStyle: CalculationStyle
    @Published public var showPoints: Bool
    @Published public var lineWidth: CGFloat
    @Published public var lineColor : Color
    @Published public var data: [CGFloat]
    @Published public var fillWithLinearGradient: LinearGradient?
    @Published public var showLineWhenFilled: Bool
    @Published public var pointColor: Color
    @Published public var dashOfLine: [CGFloat]
    @Published public var isBadgeViewEnabled: Bool
    @Published public var badgeViewModel: BadgeValueModel
    
    public init(data: [CGFloat],
                calculationStyle: CalculationStyle,
                lineWidth: CGFloat,
                showPoints: Bool,
                lineColor: Color,
                pointColor: Color,
                fillWithLinearGradient: LinearGradient? = nil,
                showLineWhenFilled: Bool,
                dashOfLine: [CGFloat] = [],
                isBadgeViewEnabled: Bool = false,
                badgeViewModel: BadgeValueModel = BadgeValueModel()) {
        self.data = data
        self.calculationStyle = calculationStyle
        self.lineWidth = lineWidth
        self.showPoints = showPoints
        self.lineColor = lineColor
        self.fillWithLinearGradient = fillWithLinearGradient
        self.showLineWhenFilled = showLineWhenFilled
        self.pointColor = pointColor
        self.dashOfLine = dashOfLine
        self.isBadgeViewEnabled = isBadgeViewEnabled
        self.badgeViewModel = badgeViewModel
    }
}
