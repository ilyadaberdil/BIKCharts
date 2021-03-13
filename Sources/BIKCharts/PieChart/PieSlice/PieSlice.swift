//
//  PiePieceView.swift
//  Charts
//
//  Created by Berdil İlyada Karacam on 1.08.2020.
//  Copyright © 2020 Berdil İlyada Karacam. All rights reserved.
//

import SwiftUI

struct PieSlice: View {
    
    // MARK: - Properties
    
    private let viewModel: PieSliceModel
    
    init(viewModel: PieSliceModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - Body
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                PieShape(viewModel: viewModel.pieShapeModel)
                    .fill(viewModel.color)
                titleText
            }
        }
    }
}


// MARK: - Views

private extension PieSlice {
    var titleText: some View {
        Text(viewModel.titleConfiguration.title)
            .foregroundColor(viewModel.titleConfiguration.foregroundColor)
            .font(viewModel.titleConfiguration.font)
            .position(viewModel.textPosition)
    }
}

// MARK: - Preview

struct PieSliceView_Previews: PreviewProvider {
    static var previews: some View {
        PieSlice(viewModel: .init(pieShapeModel: .init(startDegree: 0,
                                                           endDegree: 90,
                                                           radius: 30),
                                      color: .red,
                                      textPosition: .zero))
    }
}
