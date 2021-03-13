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
                if viewModel.isBadgeViewEnabled {
                    getDraggableView(content: {
                        getStackViewWithBars(proxy: proxy)
                    }, proxy: proxy)
                    getBadgeValueView(with: proxy)
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
                            if viewModel.direction == .horizontal {
                                index = Int(floor((dragGesture.location.x + viewModel.barSpacing) / (barWidth + viewModel.barSpacing)))
                            } else {
                                index = Int(floor((dragGesture.location.y + viewModel.barSpacing) / (barHeight + viewModel.barSpacing)))
                            }
                            let safeIndex = index < .zero ? .zero : min(index, viewModel.data.count-1)
                            
                            let safeXPoint: CGFloat
                            let safeYPoint: CGFloat
                            if viewModel.direction == .horizontal {
                                safeXPoint = dragGesture.location.x + Const.badgeViewSize.width / 2
                                safeYPoint = proxy.height / 2
                            } else {
                                safeXPoint = proxy.width / 2
                                safeYPoint = dragGesture.location.y + Const.badgeViewSize.height / 2
                            }
                            let safeLocation: CGPoint = .init(x: safeXPoint, y: safeYPoint)
                            badgeValue = viewModel.data[safeIndex]
                            badgeViewLocation = safeLocation
                            showBadgeView = true
                            isBadgeAppeared = true
                            dragAction?(viewModel.data[safeIndex])
                        }.onEnded( {dragGesture in
                            showBadgeView = false
                        }))
    }
    
    func getBadgeValueView(with proxy: GeometryProxy) -> some View {
        BadgeValue(with: viewModel.badgeViewModel, direction: viewModel.direction, value: $badgeValue)
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
            guard let maxValue = viewModel.data.max() else {
                fatalError("Cannot found maximum value!")
            }
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
}

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
