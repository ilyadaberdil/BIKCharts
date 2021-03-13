//
//  VerticalBar.swift
//  Charts
//
//  Created by berdil karaçam on 12.03.2020.
//  Copyright © 2020 Berdil İlyada Karacam. All rights reserved.
//

import SwiftUI

struct HorizontalBar: View {
    
    // MARK: - Properties
    
    private let viewModel: BarModel
    
    init(viewModel: BarModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - Body

    var body: some View {
        GeometryReader { proxy in
            HStack(spacing: .zero) {
                valueDescriptionText
                ZStack(alignment: .leading) {
                    emptyRect
                    filledRect
                    valueText
                }
                Spacer()
            }.animation(.default)
        }
    }
}

// MARK: - Views

private extension HorizontalBar {
    
    var emptyRect: some View {
        Rectangle()
            .foregroundColor(viewModel.emptyBarColor)
            .frame(width: viewModel.barWidth,
                   height: viewModel.barHeight)
            .cornerRadius(viewModel.barCornerRadius)
            .layoutPriority(100)
    }
    
    var filledRect: some View {
        Rectangle()
            .foregroundColor(viewModel.fillBarColor)
            .frame(width: calculateFillBarWidth(),
                   height: viewModel.barHeight)
            .cornerRadius(viewModel.barCornerRadius)
            .layoutPriority(100)
    }
    
    @ViewBuilder
    var valueText: some View {
        if self.viewModel.showValueText {
            Text(String(format: "%.1f", (viewModel.value)))
                .offset(x: viewModel.barWidth - (viewModel.barWidth / 4))
                .lineLimit(1)
                .font(.system(size: 10, weight: .bold))
        } else {
            EmptyView()
        }
    }
    
    @ViewBuilder
    var valueDescriptionText: some View {
        if viewModel.showValueDescription {
            if let valueName = viewModel.valueName, !valueName.isEmpty {
                Text(valueName)
                    .frame(width: viewModel.descriptionLabelSize,
                           height: viewModel.barHeight,
                           alignment: .leading)
                    .layoutPriority(99)
                    .font(.footnote)
            } else {
                Text(".")
                    .frame(width: viewModel.descriptionLabelSize,
                           height: viewModel.barHeight,
                           alignment: .leading)
                    .layoutPriority(99)
                    .hidden()
                    .font(.footnote)
            }
        } else {
            EmptyView()
        }
    }
}

// MARK: - Helper

private extension HorizontalBar {
    func calculateFillBarWidth() -> CGFloat {
        switch viewModel.calculationStyle {
        case .max(let value):
            return (CGFloat(viewModel.value) * viewModel.barWidth) / value
        case .percentage(let totalValue):
            return (CGFloat(viewModel.value) * viewModel.barWidth) / totalValue
        }
    }
}

// MARK: - Preview

struct HorizontalBar_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalBar(viewModel: .init(value: 50,
                                       valueName: "test",
                                       calculationStyle: .percentage(totalValue: 100),
                                       fillBarColor: .green,
                                       emptyBarColor: .gray,
                                       barWidth: 100,
                                       barHeight: 50,
                                       barCornerRadius: 10,
                                       descriptionLabelSize: 50,
                                       showValueText: true,
                                       showValueDescription: true))
            .previewLayout(.fixed(width: 150, height: 50))
    }
}
