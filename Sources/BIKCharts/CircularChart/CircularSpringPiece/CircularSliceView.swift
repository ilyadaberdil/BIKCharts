//
//  CircularSpringPieceView.swift
//  Charts
//
//  Created by Berdil İlyada Karacam on 30.07.2020.
//  Copyright © 2020 Berdil İlyada Karacam. All rights reserved.
//

import SwiftUI

struct CircularSliceView: View {
    
    // MARK: - Properties

    private let viewModel: CircularSliceModel
    
    init(with viewModel: CircularSliceModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - Body

    var body: some View {
        slice
    }
}

// MARK: - Views

private extension CircularSliceView {
    var slice: some View {
        Circle()
            .trim(from: viewModel.trim.from, to: viewModel.trim.to)
            .stroke(viewModel.color,
                    style: viewModel.strokeStyle)
            .rotationEffect(.degrees(viewModel.rotationDegree))
            .padding(viewModel.padding)
            .animation(.easeInOut)
    }
}

// MARK: - Preview

struct CircularSpringPieceView_Previews: PreviewProvider {
    static var previews: some View {
        CircularSliceView(with: .init(shouldTrim: true,
                                      trim: (0, 0.4),
                                      rotationDegree: 180,
                                      padding: 30,
                                      color: Color.red,
                                      strokeStyle: .init()))
    }
}
