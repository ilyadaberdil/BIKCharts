//
//  PieMockData.swift
//  
//
//  Created by Berdil İlyada Karacam on 14.03.2021.
//

import SwiftUI

struct PieMockData {
    let sampleModel1 = PieChartModel(data: mockPieModels,
                                     borderStyle: .init(circumferenceBorderStrokeStyle: .init(lineWidth: 3,
                                                                                              lineCap: .butt,
                                                                                              lineJoin: .bevel,
                                                                                              dash: [20]),
                                                        circumferenceBorderColor: .pink))
    let sampleModel2 = PieChartModel(data: mockPieModels,
                                     borderStyle: .init(circumferenceBorderStrokeStyle: .init(lineWidth: 3,
                                                                                              lineCap: .butt,
                                                                                              lineJoin: .bevel,
                                                                                              dash: [20]),
                                                        circumferenceBorderColor: .pink))
    let sampleModel3 = PieChartModel(data: mockPieModels,
                                     borderStyle: .init(circumferenceBorderStrokeStyle: .init(lineWidth: 3,
                                                                                              lineCap: .butt,
                                                                                              lineJoin: .bevel,
                                                                                              dash: [20]),
                                                        circumferenceBorderColor: .pink))
    let sampleModel4 = PieChartModel(data: mockPieModels,
                                     borderStyle: .init(circumferenceBorderStrokeStyle: .init(lineWidth: 3,
                                                                                              lineCap: .butt,
                                                                                              lineJoin: .bevel,
                                                                                              dash: [20]),
                                                        circumferenceBorderColor: .pink))
    private static let mockPieModels: [PieChartData] = [.init(slice: .init(value: 35, color: .red),
                                                              titleConfiguration: .init(title: "C",
                                                                                        foregroundColor: .black,
                                                                                        font: .headline)),
                                                        .init(slice: .init(value: 75, color: .green),
                                                              titleConfiguration: .init(title: "C++",
                                                                                        foregroundColor: .yellow,
                                                                                        font: .headline)),
                                                        .init(slice: .init(value: 55, color: .gray),
                                                              titleConfiguration: .init(title: "Java",
                                                                                        foregroundColor: .blue,
                                                                                        font: .headline)),
                                                        .init(slice: .init(value: 124, color: .orange),
                                                              titleConfiguration: .init(title: "Kotlin",
                                                                                        foregroundColor: .gray,
                                                                                        font: .headline)),
                                                        .init(slice: .init(value: 172, color: .blue),
                                                              titleConfiguration: .init(title: "Swift",
                                                                                        foregroundColor: .orange,
                                                                                 font: .headline))]
    var allMockModels: [PieChartModel] {
        return [sampleModel1, sampleModel2, sampleModel3, sampleModel4]
    }
}
