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
    private enum Const {
        static let badgeViewSize: CGSize = .init(width: 70, height: 70)
    }
    
    @ObservedObject private var viewModel: LineChartModel
    @State private var animateLine: Bool = false
    @State private var animatePoints: Bool = false
    @State private var animateGradientLayer: Bool = false
    
    
    @State private var showBadgeView: Bool = false
    @State private var badgeValue: CGFloat = .zero
    @State private var badgeViewLocation: CGPoint = .zero
    @State private var badgeViewDirection: BadgeViewDirection = .bottom
    
    //isBadgeAppeared using for set first position of badgeValueView
    @State private var isBadgeAppeared: Bool = false
    
    public init(with viewModel: LineChartModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - Body

    public var body: some View {
        GeometryReader { proxy in
            ZStack {
                getDraggableView(content: {
                    getGradientOverlayIfNeeded()
                        .overlay(getLineOverlayIfNeeded())
                        .overlay(getPointOverlayIfNeeded())
                    //                if viewModel.$badgeViewModel {
                    getBadgeValueView(with: proxy)
                    //                }
                }, proxy: proxy)
            }
        }
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
    
    //TODO: Fix naming of this func
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
    
    func getDraggableView<Content: View>(@ViewBuilder content: () -> Content, proxy: GeometryProxy) -> some View {
        content()
            .gesture(DragGesture(minimumDistance: .zero, coordinateSpace: .local)
                        .onChanged { dragGesture in
                            guard proxy.height > dragGesture.location.y &&
                                    dragGesture.location.y > .zero &&
                                    proxy.width > dragGesture.location.x &&
                                    dragGesture.location.x > .zero else {
                                showBadgeView = false
                                return
                            }
                            
                            let pointSpace = (proxy.width - viewModel.lineWidth) / CGFloat(viewModel.data.count-1)
                            let index = Int((dragGesture.location.x) / pointSpace)
                            
//                            let index: Int = Int(floor((dragGesture.location.x) / CGFloat((viewModel.data.count-1))))
//                            let safeIndex = index < .zero ? .zero : min(index, viewModel.data.count-1)
                            
                            let xDot = CGFloat(index) * (proxy.width / CGFloat(viewModel.data.count-1))
                            var yDot = scalableHeight(for: viewModel.data[index], parentHeight: proxy.height)
//                            let safeLocation: CGPoint = .init(x: xDot, y: yDot)
                            withAnimation {
                                badgeViewDirection = yDot > proxy.height / 2 ? .bottom : .top
                            }
                            yDot += badgeViewDirection == .top ? Const.badgeViewSize.height : .zero
                            badgeValue = viewModel.data[index]
                            withAnimation {
                                badgeViewLocation = .init(x: xDot, y: yDot)
                            }
                            showBadgeView = true //viewModel.isBadgeViewEnabled
                            isBadgeAppeared = true // viewModel.isBadgeViewEnabled
//                            dragAction?(viewModel.data[safeIndex])
                            print(xDot)
                        }.onEnded( {dragGesture in
                            showBadgeView = false
                        }))
    }
    
    func getBadgeValueView(with proxy: GeometryProxy) -> some View {
        BadgeValue(with: viewModel.badgeViewModel, direction: badgeViewDirection, value: $badgeValue)
            .opacity(showBadgeView ? 1 : .zero)
            .animation(.easeIn, value: showBadgeView)
            .zIndex(999)
            .frame(width: showBadgeView ? Const.badgeViewSize.width : .zero,
                   height: showBadgeView ? Const.badgeViewSize.height : .zero)
            .position(x: isBadgeAppeared ? badgeViewLocation.x : proxy.frame(in: .local).midX,
                      y: isBadgeAppeared ? badgeViewLocation.y - Const.badgeViewSize.height/2 : proxy.frame(in: .local).midY)
    }
    
    var maxValue: CGFloat {
        return viewModel.data.max() ?? .zero
    }
    
    func scalableHeight(for value: CGFloat, parentHeight: CGFloat) -> CGFloat {
        switch viewModel.calculationStyle {
        case .maxValue:
            if value == maxValue {
                return .zero
            } else {
                return parentHeight - ((parentHeight * value) / maxValue)
            }
        case .percentage:
            let sumOfData = viewModel.data.reduce(.zero, +)
            return parentHeight - ((parentHeight * value) / sumOfData)
        }
    }
}
