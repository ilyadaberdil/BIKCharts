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
        GeometryReader { proxy in
            getGradientOverlayIfNeeded(proxy: proxy)
                .overlay(getLineOverlayIfNeeded(proxy: proxy))
                .overlay(getPointOverlayIfNeeded(proxy: proxy))
        }
    }
}

// MARK: - Views

private extension LineChart {
    
    @ViewBuilder
    func getLineOverlayIfNeeded(proxy: GeometryProxy) -> some View {
        if (viewModel.showLineWhenFilled && viewModel.fillWithLinearGradient.isNotNil) ||
            viewModel.fillWithLinearGradient.isNil {
            getLinePath(proxy: proxy, shouldFill: false)
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
    
    func getGradientOverlayIfNeeded(proxy: GeometryProxy) -> some View {
        getLinePath(proxy: proxy, shouldFill: true)
            .fill((animateGradientLayer && viewModel.fillWithLinearGradient.isNotNil) ?
                    viewModel.fillWithLinearGradient! :
                    LinearGradient(gradient: .init(colors: []), startPoint: .bottom, endPoint: .bottom))
            .opacity(animateGradientLayer ? 1 : 0)
            .animateOnAppear(delay: 1.5) {
                animateGradientLayer.toggle()
            }
    }
    
    @ViewBuilder
    func getPointOverlayIfNeeded(proxy: GeometryProxy) -> some View {
        if viewModel.showPoints {
            getPointShape(proxy: proxy)
                .opacity(animatePoints ? 1 : 0)
                .animateOnAppear(delay: 0.5) {
                    animatePoints.toggle()
                }
        } else {
            EmptyView()
        }
    }
    
    func getLinePath(proxy: GeometryProxy, shouldFill: Bool) -> some Shape {
        LineShape(viewModel: .init(data: viewModel.data,
                                   shouldFill: shouldFill,
                                   calculationStyle: viewModel.calculationStyle))
    }
    
    func getPointShape(proxy: GeometryProxy) -> some View {
        return LinePointShape(viewModel: .init(data: viewModel.data,
                                               lineWidth: viewModel.lineWidth,
                                               calculationStyle: viewModel.calculationStyle))
            .stroke(viewModel.pointColor,
                    style: StrokeStyle(lineWidth: viewModel.lineWidth,
                                       lineJoin: .round))
    }
}
