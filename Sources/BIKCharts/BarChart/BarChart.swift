//
//  BarChartView.swift
//  Charts
//
//  Created by Berdil İlyada Karacam on 7.03.2020.
//  Copyright © 2020 Berdil İlyada Karacam. All rights reserved.
//

import SwiftUI

public struct BarChart: View {
    public typealias DragGestureAction = (_ data: CGFloat) -> Void
    
    enum CalculationStyle {
        case percentage(totalValue: CGFloat)
        case max(value: CGFloat)
    }
    
    private enum Const {
        static let badgeViewSize: CGSize = .init(width: 70, height: 70)
        static let horizontalBarDescriptionLabelSize: CGFloat = 18.0
        static let verticalBarDescriptionLabelSize: CGFloat = 50.0
    }
    
    // MARK: - Proporties
    
    @ObservedObject private var viewModel: BarChartModel
    @State private var showBadgeView: Bool = false
    @State private var badgeValue: CGFloat = .zero
    @State private var badgeViewLocation: CGPoint = .zero
    @State private var badgeViewDirection: BadgeViewDirection = .bottom
    @State private var shouldFillBars: Bool = false
    
    //isBadgeAppeared using for set first position of badgeValueView
    @State private var isBadgeAppeared: Bool = false
    
    private let dragAction: DragGestureAction?
    
    public init(with viewModel: BarChartModel, dragAction: DragGestureAction? = nil) {
        self.viewModel = viewModel
        self.dragAction = dragAction
    }
    
    // MARK: - Body

    public var body: some View {
        GeometryReader { proxy in
            ZStack {
                if viewModel.isBadgeViewEnabled || dragAction.isNotNil {
                    getDraggableView(content: {
                        getStackViewWithBars(proxy: proxy)
                    }, proxy: proxy)
                    if viewModel.isBadgeViewEnabled {
                        getBadgeValueView(with: proxy)
                    }
                } else {
                    getStackViewWithBars(proxy: proxy)
                }
            }.animateOnAppear {
                shouldFillBars = true
            }
        }
    }
}

// MARK: - Views

private extension BarChart {
    
    @ViewBuilder
    func getBar(barViewModel: BarModel) -> some View {
        switch viewModel.direction {
        case .horizontal:
            VerticalBar(viewModel: barViewModel)
        case .vertical:
            HorizontalBar(viewModel: barViewModel)
        }
    }
    
    @ViewBuilder
    func getStackView<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        switch viewModel.direction {
        case .horizontal:
            HStack(spacing: viewModel.barSpacing, content: content)
        case .vertical:
            VStack(alignment: .leading ,spacing: viewModel.barSpacing, content: content)
        }
    }
    
    func getStackViewWithBars(proxy: GeometryProxy) -> some View {
        getStackView() {
            ForEach(.zero..<viewModel.data.count, id: \.self) { index in
                getBar(barViewModel: getBarViewModel(at: index, proxy: proxy))
            }
        }
    }
    
    func getDraggableView<Content: View>(content: () -> Content, proxy: GeometryProxy) -> some View {
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
                            let barWidth = getCalculatedBarSize(proxy: proxy).width
                            let barHeight = getCalculatedBarSize(proxy: proxy).height
                            
                            let index: Int
                            let safeIndex: Int
                            
                            let safeXPoint: CGFloat
                            let safeYPoint: CGFloat
                            
                            if viewModel.direction == .horizontal {
                                index = Int(floor((dragGesture.location.x + viewModel.barSpacing) / (barWidth + viewModel.barSpacing)))
                                safeIndex = index < .zero ? .zero : min(index, viewModel.data.count-1)
                                let fillBarSize = calculateFillBarSize(barSize: getCalculatedBarSize(proxy: proxy),
                                                                       value: viewModel.data[index],
                                                                       calculationStyle: calculationStyle)
                                withAnimation {
                                    badgeViewDirection = fillBarSize > proxy.height / 2 ? .top : .bottom
                                }
                                safeXPoint = dragGesture.location.x + Const.badgeViewSize.width / 2
                                safeYPoint = (proxy.height - fillBarSize - barDescriptionLabelSize) +
                                    (badgeViewDirection == .top ? Const.badgeViewSize.height : .zero)
                            } else {
                                index = Int(floor((dragGesture.location.y + viewModel.barSpacing) / (barHeight + viewModel.barSpacing)))
                                safeIndex = index < .zero ? .zero : min(index, viewModel.data.count-1)
                                let fillBarSize = calculateFillBarSize(barSize: getCalculatedBarSize(proxy: proxy),
                                                                       value: viewModel.data[index],
                                                                       calculationStyle: calculationStyle)
                                withAnimation {
                                    badgeViewDirection = fillBarSize > proxy.width / 2 ? .right : .left
                                }
                                safeXPoint = fillBarSize + barDescriptionLabelSize +
                                    (badgeViewDirection == .left ? Const.badgeViewSize.height : .zero)
                                safeYPoint = dragGesture.location.y + Const.badgeViewSize.height / 2
                            }
                            let safeLocation: CGPoint = .init(x: safeXPoint, y: safeYPoint)
                            
                            badgeValue = viewModel.data[safeIndex]
                            withAnimation {
                                badgeViewLocation = safeLocation
                            }
                            showBadgeView = viewModel.isBadgeViewEnabled
                            isBadgeAppeared = viewModel.isBadgeViewEnabled
                            dragAction?(viewModel.data[safeIndex])
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
            .position(x: isBadgeAppeared ? badgeViewLocation.x - Const.badgeViewSize.width/2 : proxy.frame(in: .local).midX,
                      y: isBadgeAppeared ? badgeViewLocation.y - Const.badgeViewSize.height/2 : proxy.frame(in: .local).midY)
    }
}

// MARK: - Helper

private extension BarChart {
    var calculationStyle: CalculationStyle {
        switch viewModel.calculationType {
        case .maxValue:
            let maxValue = viewModel.data.max() ?? .zero
            return .max(value: maxValue)
        case .percentage:
            return .percentage(totalValue: CGFloat(viewModel.data.reduce(.zero, +)))
        }
    }
    
    var barDescriptionLabelSize: CGFloat {
        guard viewModel.showValueDescription else {
            return .zero
        }
        switch viewModel.direction {
        case .horizontal:
            return Const.horizontalBarDescriptionLabelSize
        case .vertical:
            return Const.verticalBarDescriptionLabelSize
        }
    }
    
    func getDescription(at index: Int) -> String? {
        if let descriptions = viewModel.dataDescriptions, descriptions.count > index {
            return descriptions[index]
        } else {
            return nil
        }
    }
    
    func getBarViewModel(at index: Int, proxy: GeometryProxy) -> BarModel {
        BarModel(value: shouldFillBars ? viewModel.data[index] : .zero,
                 valueName: getDescription(at: index),
                 calculationStyle: calculationStyle,
                 fillBarColor: viewModel.fillBarColor,
                 emptyBarColor: viewModel.emptyBarColor,
                 barWidth: getCalculatedBarSize(proxy: proxy).width,
                 barHeight: getCalculatedBarSize(proxy: proxy).height,
                 barCornerRadius: viewModel.barCornerRadius,
                 descriptionLabelSize: barDescriptionLabelSize,
                 showValueText: viewModel.showValueText,
                 showValueDescription: viewModel.showValueDescription)
    }
    
    func getCalculatedBarSize(proxy: GeometryProxy) -> CGSize {
        let width: CGFloat
        let height: CGFloat
        switch viewModel.direction {
        case .horizontal:
            width = (proxy.width - viewModel.barSpacing * CGFloat(viewModel.data.count-1)) / CGFloat(viewModel.data.count)
            height = proxy.height - barDescriptionLabelSize
        case .vertical:
            width = proxy.width - barDescriptionLabelSize
            height = (proxy.height - viewModel.barSpacing * CGFloat(viewModel.data.count-1)) / CGFloat(viewModel.data.count)
        }
        return .init(width: width, height: height)
    }
    
    func calculateFillBarSize(barSize: CGSize, value: CGFloat, calculationStyle: CalculationStyle) -> CGFloat {
        switch calculationStyle {
        case .max(let maxValue):
            switch viewModel.direction {
            case .horizontal:
                return (value * barSize.height) / maxValue
            case .vertical:
                return (value * barSize.width) / maxValue
            }
        case .percentage(let totalValue):
            switch viewModel.direction {
            case .horizontal:
                return (value * barSize.height) / totalValue
            case .vertical:
                return (value * barSize.width) / totalValue
            }
        }
    }
    
    
}

// MARK: - Preview

struct BarChart_Previews: PreviewProvider {
    static var previews: some View {
        BarChart(with: .init(data: [50, 100, 150],
                             dataDescriptions: ["test",nil,"deneme"],
                             calculationType: .percentage,
                             barSpacing: 10,
                             fillBarColor: .green,
                             emptyBarColor: .gray,
                             barCornerRadius: 10,
                             showValueText: true,
                             showValueDescription: true,
                             direction: .vertical))
            .previewLayout(.fixed(width: 400, height: 400))
    }
}
