//
//  LineShape.swift
//  Charts
//
//  Created by Berdil İlyada Karacam on 15.03.2020.
//  Copyright © 2020 Berdil İlyada Karacam. All rights reserved.
//

import SwiftUI

struct LineShape: Shape {
    
    // MARK: - Properties
    
    private let viewModel: LineShapeModel
    
    init(viewModel: LineShapeModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - Path
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            for (index, value) in viewModel.data.enumerated() {
                let xDot = CGFloat(index) * (rect.width / CGFloat(viewModel.data.count-1))
                let yDot = scalableHeight(for: value, parentHeight: rect.height)
                let point = CGPoint(x: xDot, y: yDot)
                if index == 0 {
                    if viewModel.shouldFill {
                        path.move(to: .init(x: 0, y: rect.height))
                        path.addLine(to: point)
                    } else {
                        path.move(to: point)
                    }
                } else {
                    path.addLine(to: point)
                }
            }
            if viewModel.shouldFill {
                path.addLine(to: .init(x: CGFloat(viewModel.data.count-1) * (rect.width / CGFloat(viewModel.data.count-1)),
                                       y: rect.height))
            }
        }
    }
}

// MARK: - Helper

private extension LineShape {
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
