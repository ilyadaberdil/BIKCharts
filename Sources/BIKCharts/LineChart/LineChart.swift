//
//  LineChart.swift
//  Charts
//
//  Created by berdil karaçam on 9.03.2020.
//  Copyright © 2020 Berdil İlyada Karacam. All rights reserved.
//

import SwiftUI

public struct LineChart: View {
    
    // MARK: - Properties

    @ObservedObject private var viewModel: LineChartModel
    @State private var animateLine: Bool = false
    @State private var animatePoints: Bool = false
    @State private var animateGradientLayer: Bool = false
    
    public init(with viewModel: LineChartModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - Body

    public var body: some View {
        getGradientOverlayIfNeeded()
            .overlay(getLineOverlayIfNeeded())
            .overlay(getPointOverlayIfNeeded())
    }
}

// MARK: - Views

private extension LineChart {
    
    @ViewBuilder
    func getLineOverlayIfNeeded() -> some View {
        if (viewModel.showLineWhenFilled && viewModel.fillWithLinearGradient.isNotNil) ||
            viewModel.fillWithLinearGradient.isNil {
            getLinePath(shouldFill: false)
                .trim(from: .zero, to: animateLine ? 1 : .zero)
                .stroke(viewModel.lineColor,
                        style: StrokeStyle(lineWidth: viewModel.lineWidth,
                                           lineJoin: .round,
                                           dash: viewModel.dashOfLine))
                .animateOnAppear(delay: 1) {
                    animateLine.toggle()
                }
        } else {
            EmptyView()
        }
    }
    
    func getGradientOverlayIfNeeded() -> some View {
        getLinePath(shouldFill: true)
            .fill((animateGradientLayer && viewModel.fillWithLinearGradient.isNotNil) ?
                    viewModel.fillWithLinearGradient! :
                    LinearGradient(gradient: .init(colors: []), startPoint: .bottom, endPoint: .bottom))
            .opacity(animateGradientLayer ? 1 : 0)
            .animateOnAppear(delay: 1.5) {
                animateGradientLayer.toggle()
            }
    }
    
    @ViewBuilder
    func getPointOverlayIfNeeded() -> some View {
        if viewModel.showPoints {
            getPointShape()
                .opacity(animatePoints ? 1 : 0)
                .animateOnAppear(delay: 0.5) {
                    animatePoints.toggle()
                }
        } else {
            EmptyView()
        }
    }
    
    func getLinePath(shouldFill: Bool) -> some Shape {
        LineShape(viewModel: .init(data: viewModel.data,
                                   shouldFill: shouldFill,
                                   calculationStyle: viewModel.calculationStyle))
    }
    
    func getPointShape() -> some View {
        return LinePointShape(viewModel: .init(data: viewModel.data,
                                               lineWidth: viewModel.lineWidth,
                                               calculationStyle: viewModel.calculationStyle))
            .stroke(viewModel.pointColor,
                    style: StrokeStyle(lineWidth: viewModel.lineWidth,
                                       lineJoin: .round))
    }
}
