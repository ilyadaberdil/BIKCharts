//
//  PointShape.swift
//  Charts
//
//  Created by Berdil İlyada Karacam on 15.03.2020.
//  Copyright © 2020 Berdil İlyada Karacam. All rights reserved.
//

import SwiftUI

struct LinePointShape: Shape {
    
    private let viewModel: LinePointShapeModel
    
    init(viewModel: LinePointShapeModel) {
        self.viewModel = viewModel
    }
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            for index in 0..<viewModel.data.count {
                let xDot = CGFloat(index) * (rect.width / CGFloat(viewModel.data.count-1))
                let yDot = scalableHeight(at: index,
                                          parentHeight: rect.height)
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
    
    private func scalableHeight(at index: Int, parentHeight: CGFloat) -> CGFloat {
        switch viewModel.calculationStyle {
        case .maxValue:
            if viewModel.data[index] > parentHeight {
                return .zero
            } else {
                return  parentHeight - viewModel.data[index]
            }
        case .percentage:
            let sumOfData = viewModel.data.reduce(.zero, +)
            let data = viewModel.data[index]
            return parentHeight - ((parentHeight * data) / sumOfData)
        }
    }
}
