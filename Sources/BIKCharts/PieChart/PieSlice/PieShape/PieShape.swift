//
//  PieShape.swift
//  Charts
//
//  Created by Berdil İlyada Karacam on 15.03.2020.
//  Copyright © 2020 Berdil İlyada Karacam. All rights reserved.
//

import SwiftUI

struct PieShape: Shape {
    
    // MARK: - Properties
    
    private let viewModel: PieShapeModel
    
    init(viewModel: PieShapeModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - Path
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            let center = CGPoint(x: rect.midX, y: rect.midY)
            path.move(to: center)
            path.addArc(center: center,
                        radius: viewModel.radius,
                        startAngle: .degrees(viewModel.startDegree),
                        endAngle: .degrees(viewModel.endDegree),
                        clockwise: false)
        }
    }
}

// MARK: - Preview

struct PieShape_Previews: PreviewProvider {
    static var previews: some View {
        PieShape(viewModel: .init(startDegree: 0,
                                  endDegree: 30,
                                  radius: 35)).fill(Color.red)
    }
}
