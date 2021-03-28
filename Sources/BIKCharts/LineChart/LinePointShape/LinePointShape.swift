//
//  PointShape.swift
//  Charts
//
//  Created by Berdil İlyada Karacam on 15.03.2020.
//  Copyright © 2020 Berdil İlyada Karacam. All rights reserved.
//

import SwiftUI

struct LinePointShape: Shape {
    
    // MARK: - Properties
    
    private let viewModel: LinePointShapeModel
    
    init(viewModel: LinePointShapeModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - Path

    func path(in rect: CGRect) -> Path {
        Path { path in
            for (index, data) in viewModel.data.enumerated() {
                let xDot = CGFloat(index) * (rect.width / CGFloat(viewModel.data.count-1))
                let yDot = scalableHeight(for: data, parentHeight: rect.height)
                let point = CGPoint(x: xDot, y: yDot)
                
                path.move(to: point)
                path.addRoundedRect(in: .init(x: point.x - viewModel.lineWidth/2,
                                              y: point.y - viewModel.lineWidth/2,
                                              width: viewModel.lineWidth,
                                              height: viewModel.lineWidth),
                                    cornerSize: .init(
                                        width: viewModel.lineWidth,
                                        height: viewModel.lineWidth))
            }
        }
    }
}

// MARK: - Helper

private extension LinePointShape {
    
    var maxValue: CGFloat {
        return viewModel.data.max() ?? .zero
    }
    
    func scalableHeight(for value: CGFloat, parentHeight: CGFloat) -> CGFloat {
        switch viewModel.calculationStyle {
        case .maxValue:
            if value == maxValue {
                return .zero
            } else {
                return parentHeight - ((parentHeight * value) / maxValue)
            }
        case .percentage:
            let sumOfData = viewModel.data.reduce(.zero, +)
            return parentHeight - ((parentHeight * value) / sumOfData)
        }
    }
}
