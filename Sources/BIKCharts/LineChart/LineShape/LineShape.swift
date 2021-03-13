//
//  LineShape.swift
//  Charts
//
//  Created by Berdil İlyada Karacam on 15.03.2020.
//  Copyright © 2020 Berdil İlyada Karacam. All rights reserved.
//

import SwiftUI

struct LineShape: Shape {
    
    private let viewModel: LineShapeModel
    
    init(viewModel: LineShapeModel) {
        self.viewModel = viewModel
    }
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            for index in 0..<viewModel.data.count {
                let xDot = CGFloat(index) * (rect.width / CGFloat(viewModel.data.count-1))
                let yDot = scalableHeight(of: index,
                                               parentHeight: rect.height)
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
    
    private func scalableHeight(of index: Int, parentHeight: CGFloat) -> CGFloat {
        switch viewModel.calculationStyle {
        case .maxValue:
            if viewModel.data[index] > parentHeight {
                return 0
            } else {
                return  parentHeight - viewModel.data[index]
            }
        case .percentage:
            let sumOfData = viewModel.data.reduce(0, +)
            let data = viewModel.data[index]
            return parentHeight - ((parentHeight * data) / sumOfData)
        }
    }
    
}
//
//struct LineShape_Previews: PreviewProvider {
//    static var previews: some View {
//        LineShape(viewModel: .constant(.init(data: Mock().values,
//                                             shouldFill: false,
//                                             calculationStyle: .maxValue)))
//    }
//}
