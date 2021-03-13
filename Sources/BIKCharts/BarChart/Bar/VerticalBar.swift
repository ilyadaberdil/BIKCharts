//
//  RectangleBar.swift
//  Charts
//
//  Created by Berdil İlyada Karacam on 7.03.2020.
//  Copyright © 2020 Berdil İlyada Karacam. All rights reserved.
//

import SwiftUI

struct VerticalBar: View {
    
    // MARK: - Properties

    private let viewModel: BarModel
    
    init(viewModel: BarModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - Body
    
    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: .zero) {
                ZStack(alignment: .bottom) {
                    emptyRect
                    filledRect
                    valueText
                }
                valueDescriptionText
            }.animation(.default)
        }
    }
}

// MARK: - Views

private extension VerticalBar {
    
    var emptyRect: some View {
        Rectangle()
            .foregroundColor(viewModel.emptyBarColor)
            .frame(width: viewModel.barWidth,
                   height: viewModel.barHeight)
            .cornerRadius(viewModel.barCornerRadius)
    }
    
    var filledRect: some View {
        Rectangle()
            .foregroundColor(viewModel.fillBarColor)
            .frame(width: viewModel.barWidth,
                   height: calculateFillBarHeight())
            .cornerRadius(viewModel.barCornerRadius)
    }
    
    @ViewBuilder
    var valueText: some View {
        if viewModel.showValueText {
            Text(String(format: "%.1f", (viewModel.value)))
                .rotationEffect(.init(radians: -.pi/2))
                .lineLimit(1)
                .offset(x: 0, y: viewModel.barWidth - viewModel.barHeight)
                .font(.system(size: 10, weight: .bold))
                .frame(width: viewModel.barWidth, height: viewModel.barWidth - 4)
        } else {
            EmptyView()
        }
    }
    
    @ViewBuilder
    var valueDescriptionText: some View {
        if viewModel.showValueDescription {
            if let valueName = viewModel.valueName, !valueName.isEmpty {
                Text(valueName)
                    .frame(width: viewModel.barWidth,
                           height: viewModel.descriptionLabelSize,
                           alignment: .center)
                    .font(.footnote)
            } else {
                Text(".")
                    .hidden()
                    .frame(width: viewModel.barWidth,
                           height: viewModel.descriptionLabelSize,
                           alignment: .center)
                    .font(.footnote)
            }
        } else {
            EmptyView()
        }
    }
}

// MARK: - Helper

private extension VerticalBar {
    func calculateFillBarHeight() -> CGFloat {
        switch viewModel.calculationStyle {
        case .max(let value):
            return (CGFloat(viewModel.value) * viewModel.barHeight) / value
        case .percentage(let totalValue):
            return (CGFloat(viewModel.value) * viewModel.barHeight) / totalValue
        }
    }
}

// MARK: - Preview

struct VerticalBar_Previews: PreviewProvider {
    static var previews: some View {
        VerticalBar(viewModel: .init(value: 50,
                                     valueName: "test",
                                     calculationStyle: .percentage(totalValue: 100),
                                     fillBarColor: .green,
                                     emptyBarColor: .gray,
                                     barWidth: 50,
                                     barHeight: 100,
                                     barCornerRadius: 10,
                                     descriptionLabelSize: 18,
                                     showValueText: true,
                                     showValueDescription: true))
            .previewLayout(.fixed(width: 150, height: 150))
    }
}
