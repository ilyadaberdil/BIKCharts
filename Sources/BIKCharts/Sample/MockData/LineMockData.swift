//
//  File.swift
//  
//
//  Created by Berdil İlyada Karacam on 14.03.2021.
//

import SwiftUI

struct LineMockData {
    let sampleModel1 = LineChartModel(data: Mock().values,
                                      calculationStyle: .maxValue,
                                      lineWidth: 2,
                                      showPoints: true,
                                      lineColor: .red,
                                      pointColor: .gray,
                                      fillWithLinearGradient: nil,
                                      showLineWhenFilled: false,
                                      dashOfLine: [])
    let sampleModel2 = LineChartModel(data: Array(Mock().values.prefix(5)),
                                      calculationStyle: .maxValue,
                                      lineWidth: 4,
                                      showPoints: false,
                                      lineColor: .blue,
                                      pointColor: .orange,
                                      fillWithLinearGradient: .init(gradient: Gradient(colors: [.red, .green, .purple]), startPoint: .bottom, endPoint: .top),
                                      showLineWhenFilled: true,
                                      dashOfLine: [0])
    let sampleModel3 = LineChartModel(data: Array(Mock().values.suffix(5)),
                                      calculationStyle: .percentage,
                                      lineWidth: 1,
                                      showPoints: false,
                                      lineColor: .black,
                                      pointColor: .pink,
                                      fillWithLinearGradient: nil,
                                      showLineWhenFilled: false,
                                      dashOfLine: [])
    let sampleModel4 = LineChartModel(data: Mock().values,
                                      calculationStyle: .maxValue,
                                      lineWidth: 5,
                                      showPoints: true,
                                      lineColor: .green,
                                      pointColor: .blue,
                                      fillWithLinearGradient: .init(gradient: Gradient(colors: [.yellow, .orange, .pink]), startPoint: .bottomLeading, endPoint: .bottomTrailing),
                                      showLineWhenFilled: true,
                                      dashOfLine: [])
    var allMockModels: [LineChartModel] {
        return [sampleModel1, sampleModel2, sampleModel3, sampleModel4]
    }
}
