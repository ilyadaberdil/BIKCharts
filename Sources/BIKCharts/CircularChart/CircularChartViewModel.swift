//
//  CircularChartViewModel.swift
//  Charts
//
//  Created by Berdil İlyada Karacam on 30.07.2020.
//  Copyright © 2020 Berdil İlyada Karacam. All rights reserved.
//

import Foundation
import SwiftUI

class CircularChartViewModel: ObservableObject {

    @Published var data: [ChartSliceDataModel]
    @Published var calculationStyle: CalculationStyle
    @Published var strokeStyle: StrokeStyle
    
    init(data: [ChartSliceDataModel],
         calculationStyle: CalculationStyle = .maxValue,
         strokeStyle: StrokeStyle = .init(lineWidth: 16,
                                          lineCap: .round,
                                          dash: [])) {
        self.data = data
        self.calculationStyle = calculationStyle
        self.strokeStyle = strokeStyle
    }
}
