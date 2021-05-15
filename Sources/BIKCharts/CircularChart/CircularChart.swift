
//
//  CircularChart.swift
//  Charts
//
//  Created by Berdil İlyada Karacam on 28.07.2020.
//  Copyright © 2020 Berdil İlyada Karacam. All rights reserved.
//

import SwiftUI

struct CircularChart: View {
    // TODO: Convert default color to ColorSet
    private enum Const {
        static let circleWholeAreaRate: CGFloat = 0.5
        static let circleWholeAreaDegree: CGFloat = 180.0
        static let defaultColor: Color = .orange
    }
    
    // MARK: - Properties
    
    @ObservedObject private var viewModel: CircularChartModel
    @State private var shouldTrim = false
    
    public init(with viewModel: CircularChartModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - Body
    
    public var body: some View {
        GeometryReader { proxy in
            ZStack {
                ForEach(0..<sortedValues.count, id: \.self) { index in
                    getSlice(at: index, proxy: proxy)
                        .animateOnAppear(using: .linear) {
                            shouldTrim = true
                        }
                        .frame(width: proxy.width,
                               height: proxy.height)
                }
            }
        }
    }
}

// MARK: - Views

private extension CircularChart {
    func getSlice(at index: Int, proxy: GeometryProxy) -> some View {
        let model = CircularSliceModel(shouldTrim: shouldTrim,
                                       trim: (from: .zero, to: shouldTrim ? getCalculatedValue(at: index) : .zero),
                                       rotationDegree: getCalculatedRotationDegree(for: getCalculatedValue(at: index)),
                                       padding: getCalculatedPadding(at: index, for: proxy),
                                       color: viewModel.data[index].color ?? Const.defaultColor,
                                       strokeStyle: viewModel.strokeStyle)
        return CircularSliceView(with: model)
    }
}

// MARK: - Helper

private extension CircularChart {
    
    var sortedValues: [CGFloat] {
        return viewModel.data.map{$0.value}.sorted(by: >)
    }
    
    var maxValue: CGFloat {
        guard let maxValue = viewModel.data.map({$0.value}).max() else {
            fatalError("Cannot found maximum value!")
        }
        return maxValue
    }
    
    var circlePadding: CGFloat {
        return viewModel.strokeStyle.lineWidth*3/2
    }
    
    func getCalculatedPadding(at index: Int, for proxy: GeometryProxy) -> CGFloat {
        return floor(circlePadding * CGFloat(index+1))
    }
    
    func getCalculatedValue(at index: Int) -> CGFloat {
        switch viewModel.calculationStyle {
        case .maxValue:
            let data = sortedValues[index]
            if data == maxValue {
                return Const.circleWholeAreaRate
            } else {
                return data * Const.circleWholeAreaRate / maxValue
            }
        case .percentage:
            let sumOfValues = sortedValues.reduce(.zero, +)
            return (sortedValues[index] * Const.circleWholeAreaRate) / sumOfValues
        }
    }
    
    func getCalculatedRotationDegree(for calculatedValue: CGFloat) -> Double {
        return Double((((Const.circleWholeAreaRate/2) - (calculatedValue/2)) * Const.circleWholeAreaDegree)/Const.circleWholeAreaRate) - Double(Const.circleWholeAreaDegree)
    }
}

// MARK: - Preview

struct CircularChart_Previews: PreviewProvider {
    static var previews: some View {
        CircularChart(with: .init(data: [.init(value: 25, color: .red),
                                         .init(value: 35, color: .orange),
                                         .init(value: 55, color: .purple),
                                         .init(value: 45, color: .blue)]))
    }
}
