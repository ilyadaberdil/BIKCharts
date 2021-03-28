//
//  CircularMockData.swift
//  
//
//  Created by Berdil İlyada Karacam on 14.03.2021.
//

import SwiftUI

struct CircularMockData {
    let sampleModel1 = CircularChartModel(data: mockCircularSliceModels,
                                          calculationStyle: .maxValue,
                                          strokeStyle: .init(lineWidth: 12,
                                                             lineCap: .round,
                                                             lineJoin: .miter,
                                                             dash: []))
    
    let sampleModel2 = CircularChartModel(data: mockCircularSliceModels,
                                          calculationStyle: .maxValue,
                                          strokeStyle: .init(lineWidth: 12,
                                                             lineCap: .round,
                                                             lineJoin: .miter,
                                                             dash: []))
    
    let sampleModel3 = CircularChartModel(data: mockCircularSliceModels,
                                          calculationStyle: .maxValue,
                                          strokeStyle: .init(lineWidth: 12,
                                                             lineCap: .round,
                                                             lineJoin: .miter,
                                                             dash: []))
    
    let sampleModel4 = CircularChartModel(data: mockCircularSliceModels,
                                          calculationStyle: .maxValue,
                                          strokeStyle: .init(lineWidth: 1,
                                                             lineCap: .round,
                                                             lineJoin: .miter,
                                                             dash: []))
    
    private static let mockCircularSliceModels: [ChartSliceDataModel] = [
        .init(value: 25, color: .red),
        .init(value: 75, color: .gray),
        .init(value: 55, color: .yellow),
        .init(value: 122, color: .green),
        .init(value: 250, color: .orange),
    ]
    
    var allMockModels: [CircularChartModel] {
        return [sampleModel1, sampleModel2, sampleModel3, sampleModel4]
    }
}
