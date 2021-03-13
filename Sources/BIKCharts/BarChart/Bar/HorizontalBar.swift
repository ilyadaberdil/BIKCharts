//
//  VerticalBar.swift
//  Charts
//
//  Created by berdil karaçam on 12.03.2020.
//  Copyright © 2020 Berdil İlyada Karacam. All rights reserved.
//

import SwiftUI

struct HorizontalBar: View {
    
    private let viewModel: BarModel
    
    init(viewModel: BarModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        GeometryReader { proxy in
            HStack(spacing: .zero) {
                if viewModel.showValueDescription {
                    if viewModel.valueName.isNotNil {
                        Text(viewModel.valueName ?? "")
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
                }
                ZStack(alignment: .leading) {
                    Rectangle()
                        .foregroundColor(viewModel.emptyBarColor)
                        .frame(width: viewModel.barWidth,
                               height: viewModel.barHeight)
                        .cornerRadius(viewModel.barCornerRadius)
                        .layoutPriority(100)
                    Rectangle()
                        .foregroundColor(viewModel.fillBarColor)
                        .frame(width: calculateFillBarWidth(),
                               height: viewModel.barHeight)
                        .cornerRadius(viewModel.barCornerRadius)
                        .layoutPriority(100)
                    if self.viewModel.showValueText {
                        Text(String(format: "%.1f", (viewModel.value)))
                            .offset(x: viewModel.barWidth - (viewModel.barWidth / 4))
                            .lineLimit(1)
                            .font(.system(size: 10, weight: .bold))
                    }
                }
                Spacer()
            }.animation(.default)
        }
    }
    
    private func calculateFillBarWidth() -> CGFloat {
        switch viewModel.calculationStyle {
        case .max(let value):
            return (CGFloat(viewModel.value) * viewModel.barWidth) / value
        case .percentage(let totalValue):
            return (CGFloat(viewModel.value) * viewModel.barWidth) / totalValue
        }
    }
    
}

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
