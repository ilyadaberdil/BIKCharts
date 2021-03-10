//
//  BarChartView.swift
//  Charts
//
//  Created by Berdil İlyada Karacam on 7.03.2020.
//  Copyright © 2020 Berdil İlyada Karacam. All rights reserved.
//

import SwiftUI

struct BarChart: View {
    typealias DragGestureAction = (_ data: CGFloat) -> Void

    enum CalculationStyle {
        case percentage(totalValue: CGFloat)
        case max(value: CGFloat)
    }
    
    private enum Const {
        static let badgeViewSize: CGSize = .init(width: 70, height: 70)
        static let horizontalBarDescriptionLabelSize: CGFloat = 18.0
        static let verticalBarDescriptionLabelSize: CGFloat = 50.0
    }
    
    @ObservedObject private var viewModel: BarChartViewModel
    @State private var showBadgeView: Bool = false
    @State private var badgeValue: CGFloat = .zero
    @State private var badgeViewLocation: CGPoint = .zero
    @State private var shouldFillBars: Bool = false
    
    //isBadgeAppeared using for set first position of badgeValueView
    @State private var isBadgeAppeared: Bool = false
    
    var dragAction: DragGestureAction?
    
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
        
    private func getCalculatedBarSize(proxy: GeometryProxy) -> CGSize {
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
    
    public init(with viewModel: BarChartViewModel, dragAction: DragGestureAction? = nil) {
        self.viewModel = viewModel
        self.dragAction = dragAction
    }
    
    private var calculationStyle: CalculationStyle {
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
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                getDraggableView(content: {
                    getStackView() {
                        ForEach(.zero..<viewModel.data.count, id: \.self) { index in
                            getBar(barViewModel: getBarViewModel(at: index, proxy: proxy))
                        }
                    }
                }, proxy: proxy)
                getBadgeValueView(with: proxy)
            }.animateOnAppear {
                shouldFillBars = true
            }
        }
    }
    
    private func getBar(barViewModel: BarViewModel) -> some View {
        viewModel.direction == .horizontal ? AnyView(VerticalBar(viewModel: barViewModel)) : AnyView(HorizontalBar(viewModel: barViewModel))
    }
    
    private func getBarViewModel(at index: Int, proxy: GeometryProxy) -> BarViewModel {
        BarViewModel(value: shouldFillBars ? viewModel.data[index] : .zero,
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
    
    private func getStackView<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        switch viewModel.direction {
        case .horizontal:
            return AnyView(HStack(spacing: viewModel.barSpacing, content: content))
        case .vertical:
            return AnyView(VStack(alignment: .leading ,spacing: viewModel.barSpacing, content: content))
        }
    }
    
    private func getDescription(at index: Int) -> String? {
        if let descriptions = viewModel.dataDescriptions, descriptions.count > index {
            return descriptions[index]
        } else {
            return nil
        }
    }
    
    private func getDraggableView<Content: View>(content: () -> Content, proxy: GeometryProxy) -> some View {
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
    
    private func getBadgeValueView(with proxy: GeometryProxy) -> some View {
        BadgeValueView(value: $badgeValue, direction: viewModel.direction)
            .opacity(showBadgeView ? 1 : .zero)
            .animation(.easeIn, value: showBadgeView)
            .zIndex(999)
            .frame(width: showBadgeView ? Const.badgeViewSize.width : .zero,
                   height: showBadgeView ? Const.badgeViewSize.height : .zero)
            .position(x: isBadgeAppeared ? badgeViewLocation.x - Const.badgeViewSize.width/2 : proxy.frame(in: .local).midX,
                      y: isBadgeAppeared ? badgeViewLocation.y - Const.badgeViewSize.height/2 : proxy.frame(in: .local).midY)
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
