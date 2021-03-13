//
//  BadgeValueView.swift
//  Charts
//
//  Created by Berdil İlyada Karacam on 6.12.2020.
//  Copyright © 2020 Berdil İlyada Karacam. All rights reserved.
//

import SwiftUI

struct BadgeValue: View {
    
    // MARK: - Proporties
    
    @Binding var value: CGFloat
    private let direction: BarChartDirection
    private let viewModel: BadgeValueModel
    
    init(with viewModel: BadgeValueModel, direction: BarChartDirection, value: Binding<CGFloat>) {
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
                .rotationEffect(direction == .vertical ? .degrees(90) : .zero)
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
