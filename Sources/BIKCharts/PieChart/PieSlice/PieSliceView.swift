//
//  PiePieceView.swift
//  Charts
//
//  Created by Berdil İlyada Karacam on 1.08.2020.
//  Copyright © 2020 Berdil İlyada Karacam. All rights reserved.
//

import SwiftUI

struct PieSliceView: View {
    
    private let viewModel: PieSliceViewModel
        
    init(viewModel: PieSliceViewModel) {
        self.viewModel = viewModel
    }
        
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                PieShape(viewModel: viewModel.pieShapeViewModel)
                    .fill(viewModel.color)
                Text(viewModel.titleConfiguration.title)
                    .foregroundColor(viewModel.titleConfiguration.foregroundColor)
                    .font(viewModel.titleConfiguration.font)
                    .position(viewModel.textPosition)
            }
        }
    }
}

struct PieSliceView_Previews: PreviewProvider {
    static var previews: some View {
        PieSliceView(viewModel: .init(pieShapeViewModel: .init(startDegree: 0,
                                                               endDegree: 90,
                                                               radius: 30),
                                      color: .red,
                                      textPosition: .zero))
    }
}
