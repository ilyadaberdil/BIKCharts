//
//  CircularChartModel.swift
//  Charts
//
//  Created by Berdil İlyada Karacam on 30.07.2020.
//  Copyright © 2020 Berdil İlyada Karacam. All rights reserved.
//

import Foundation
import SwiftUI

final public class CircularChartModel: ObservableObject, Identifiable {
    
    @Published public var data: [ChartSliceDataModel]
    @Published public var calculationStyle: CalculationStyle
    @Published public var strokeStyle: StrokeStyle
    
    public init(data: [ChartSliceDataModel],
                calculationStyle: CalculationStyle = .maxValue,
                strokeStyle: StrokeStyle = .init(lineWidth: 16,
                                                 lineCap: .round,
                                                 dash: [])) {
        self.data = data
        self.calculationStyle = calculationStyle
        self.strokeStyle = strokeStyle
    }
}
