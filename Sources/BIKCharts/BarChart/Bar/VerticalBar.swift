//
//  RectangleBar.swift
//  Charts
//
//  Created by Berdil İlyada Karacam on 7.03.2020.
//  Copyright © 2020 Berdil İlyada Karacam. All rights reserved.
//

import SwiftUI

struct VerticalBar: View {
    
    private let viewModel: BarModel
    
    init(viewModel: BarModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: .zero) {
                ZStack(alignment: .bottom) {
                    Rectangle()
                        .foregroundColor(viewModel.emptyBarColor)
                        .frame(width: viewModel.barWidth,
                               height: viewModel.barHeight)
                        .cornerRadius(viewModel.barCornerRadius)
                    Rectangle()
                        .foregroundColor(viewModel.fillBarColor)
                        .frame(width: viewModel.barWidth,
                               height: calculateFillBarHeight())
                        .cornerRadius(viewModel.barCornerRadius)
                    if viewModel.showValueText {
                        Text(String(format: "%.1f", (viewModel.value)))
                            .rotationEffect(.init(radians: -.pi/2))
                            .lineLimit(1)
                            .offset(x: 0, y: viewModel.barWidth - viewModel.barHeight)
                            .font(.system(size: 10, weight: .bold))
                            .frame(width: viewModel.barWidth, height: viewModel.barWidth - 4)
                    }
                }
                
                if let valueName = viewModel.valueName,
                   !valueName.isEmpty &&
                    viewModel.showValueDescription {
                    Text(valueName)
                        .frame(width: viewModel.barWidth,
                               height: viewModel.descriptionLabelSize,
                               alignment: .center)
                        .font(.footnote)
                } else if viewModel.showValueDescription {
                    Text(".")
                        .hidden()
                        .frame(width: viewModel.barWidth,
                               height: viewModel.descriptionLabelSize,
                               alignment: .center)
                        .font(.footnote)
                }
            }.animation(.default)
        }
    }
    
    private func calculateFillBarHeight() -> CGFloat {
        switch viewModel.calculationStyle {
        case .max(let value):
            return (CGFloat(viewModel.value) * viewModel.barHeight) / value
        case .percentage(let totalValue):
            return (CGFloat(viewModel.value) * viewModel.barHeight) / totalValue
        }
    }
    
}

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
