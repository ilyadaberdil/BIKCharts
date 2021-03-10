//
//  PieChartViewModel.swift
//  Charts
//
//  Created by Berdil İlyada Karacam on 10.12.2020.
//  Copyright © 2020 Berdil İlyada Karacam. All rights reserved.
//

import SwiftUI

public struct BorderStyle {
    let circumferenceBorderStrokeStyle: StrokeStyle
    let circumferenceBorderColor: Color
    
    public init(circumferenceBorderStrokeStyle: StrokeStyle = .init(lineWidth: 10,
                                                                    lineCap: .square,
                                                                    dash: [20]),
                circumferenceBorderColor: Color = .red) {
        self.circumferenceBorderStrokeStyle = circumferenceBorderStrokeStyle
        self.circumferenceBorderColor = circumferenceBorderColor
        
    }
}

public struct PieChartData {
    let slice: ChartSliceDataModel
    let titleConfiguration: TitleConfiguration
    
    public init(slice: ChartSliceDataModel, titleConfiguration: TitleConfiguration = TitleConfiguration()) {
        self.slice = slice
        self.titleConfiguration = titleConfiguration
    }
}

final public class PieChartViewModel: ObservableObject {
    @Published var data: [PieChartData]
    @Published var borderStyle: BorderStyle?
    
    public init(data: [PieChartData], borderStyle: BorderStyle? = BorderStyle()) {
        self.data = data
        self.borderStyle = borderStyle
    }
}

extension PieChartViewModel {
    
    private enum Const {
        static let totalDegree: CGFloat = 360.0
    }
    
    private var percentages: [CGFloat] {
        return data.map {
            Const.totalDegree * $0.slice.value / sumOfValue
        }
    }
    
    private var sumOfValue: CGFloat {
        return data.reduce(.zero) { (res, data) -> CGFloat in
            return res + data.slice.value
        }
    }
    
    func getDescriptionDegree(at index: Int) -> Double {
        return (Double(percentages[index] / 2)) + getStartDegree(of: index)
    }
    
    func getStartDegree(of index: Int) -> Double {
        return Double(percentages.prefix(index).reduce(.zero, +))
    }
    
    func getEndDegree(of index: Int) -> Double {
        return getStartDegree(of: index) + Double(percentages[index])
    }
}
