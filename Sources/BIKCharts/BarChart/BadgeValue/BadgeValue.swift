//
//  BadgeValueView.swift
//  Charts
//
//  Created by Berdil İlyada Karacam on 6.12.2020.
//  Copyright © 2020 Berdil İlyada Karacam. All rights reserved.
//

import SwiftUI

enum BadgeViewDirection {
    case top, bottom, left, right
}

struct BadgeValue: View {
    
    // MARK: - Proporties

    @Binding var value: CGFloat
    private let direction: BadgeViewDirection
    private let viewModel: BadgeValueModel
    
    init(with viewModel: BadgeValueModel, direction: BadgeViewDirection, value: Binding<CGFloat>) {
        self.viewModel = viewModel
        self.direction = direction
        self._value = value
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            BadgeShape()
                .foregroundColor(viewModel.foregroundColor)
                .cornerRadius(35)
                .rotationEffect(.degrees(rotationDegree))
            infoText
                .padding()
        }
    }
}

// MARK: - Views

private extension BadgeValue {
    var infoText: some View {
        VStack {
            Text(viewModel.title)
                .underline(viewModel.showUnderline, color: viewModel.underlineColor)
                .multilineTextAlignment(.center)
                .font(.system(size: 10))
                .lineLimit(1)
            Text("\(String(format: "%.1f", value))")
                .multilineTextAlignment(.center)
                .font(.system(size: 10))
                .lineLimit(1)
        }
    }
}

// MARK: - Helper

private extension BadgeValue {
    var rotationDegree: Double {
        switch direction {
        case .bottom:
            return .zero
        case .top:
            return 180.0
        case .left:
            return 90.0
        case .right:
            return 270.0
        }
    }
}
