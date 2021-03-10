//
//  PieChart.swift
//  Charts
//
//  Created by Berdil İlyada Karacam on 14.03.2020.
//  Copyright © 2020 Berdil İlyada Karacam. All rights reserved.
//

import SwiftUI

struct PieChart: View {
    typealias TapAction = (PieChartData) -> Void
    
    private enum Const {
        static let totalDegree: CGFloat = 360.0
    }
    
    @ObservedObject private var viewModel: PieChartViewModel
    
    @State private var shouldDraw: Bool = false
    @State private var tappedPieceIndex: Int?
    
    private var tapAction: TapAction?
    
    private var colorSet: [Color] {
        var colorSet: [Color] = []
        var colors: [Color] = [.red, .green, .yellow, .blue, .gray, .orange, .purple]
        colors.removeAll(where: { $0 == viewModel.borderStyle?.circumferenceBorderColor })
        for index in 0..<viewModel.data.count {
            colorSet.append(colors[index % colors.count])
        }
        return colorSet
    }
    
    public init(viewModel: PieChartViewModel, tapAction: TapAction? = nil) {
        self.viewModel = viewModel
        self.tapAction = tapAction
    }
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                if viewModel.borderStyle != nil {
                    getBorder(proxy: proxy)
                }
                ForEach(0..<viewModel.data.count, id: \.self) { index in
                    getPieceView(at: index, proxy: proxy)
                }
            }
            .scaleEffect(shouldDraw ? 1 : 0)
        }
        .animateOnAppear(using: .spring(response: 1, dampingFraction: 0.5, blendDuration: 0.7)) {
                shouldDraw = true
        }
    }

    private func getPieceView(at index: Int, proxy: GeometryProxy) -> some View {
        let radius = min(proxy.width, proxy.height) / 2

        let shapeViewModel = PieShapeViewModel(startDegree: viewModel.getStartDegree(of: index),
                                               endDegree: viewModel.getEndDegree(of: index), radius: radius)
        let sliceViewModel = PieSliceViewModel(pieShapeViewModel: shapeViewModel,
                                               color: viewModel.data[index].slice.color ?? colorSet[index],
                                               textPosition: getDescriptionPosition(size: proxy.size, index: index),
                                               titleConfiguration: viewModel.data[index].titleConfiguration)
        return PieSliceView(viewModel: sliceViewModel)
            .scaleEffect(tappedPieceIndex == index ? 1.2 : 1)
            .frame(width: proxy.width,
                   height: proxy.height)
            .onTapGesture {
                withAnimation {
                    tappedPieceIndex = index == tappedPieceIndex ? nil : index
                }
                tapAction?(viewModel.data[index])
        }
    }
    
    private func getDescriptionPosition(size: CGSize, index:Int) -> CGPoint {
        let center = CGPoint(x: size.width / 2 , y: size.height / 2)
        let radius = min(size.width, size.height) / 3
        let descriptionDegree = CGFloat(viewModel.getDescriptionDegree(at: index))
        
        let yPosition = radius * sin(descriptionDegree * (.pi / 180))
        let xPosition = radius * cos(descriptionDegree * (.pi / 180))
        return .init(x: center.x + xPosition, y: center.y + yPosition)
    }
    
    private func getBorder(proxy: GeometryProxy) -> some View {
        Circle()
            .stroke((viewModel.borderStyle?.circumferenceBorderColor ?? Color.red),
                    style: viewModel.borderStyle?.circumferenceBorderStrokeStyle ?? StrokeStyle())
            .frame(width: proxy.width,
                   height: proxy.height)
    }
}

struct PieChart_Previews: PreviewProvider {
    static var previews: some View {
        PieChart(viewModel: .init(data: [PieChartData(slice: .init(value: 10),
                                                      titleConfiguration: .init(title: "Berdil", foregroundColor: .blue, font: .body)),
                                         PieChartData(slice: .init(value: 10),
                                                      titleConfiguration: .init(title: "İlyada", foregroundColor: .red, font: .callout)),
                                         PieChartData(slice: .init(value: 10),
                                                      titleConfiguration: .init(title: "Karacam", foregroundColor: .gray, font: .headline)),
                                         PieChartData(slice: .init(value: 10)),
                                         PieChartData(slice: .init(value: 10),
                                                      titleConfiguration: .init(title: "Test", foregroundColor: .purple, font: .subheadline)),
        ]))
    }
}


