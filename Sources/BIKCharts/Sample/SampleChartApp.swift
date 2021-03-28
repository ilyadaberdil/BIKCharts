//
//  SwiftUIView.swift
//  
//
//  Created by Berdil İlyada Karacam on 14.03.2021.
//

import SwiftUI

public struct SampleChartApp: View {
    public var body: some View {
        GeometryReader { proxy in
            NavigationView {
                VStack(alignment: .center, spacing: 24) {
                    barChartButton
                    lineChartButton
                    circularChartButton
                    pieChartButton
                }
                .navigationBarTitle("Charts", displayMode: .large)
            }
        }
    }
    
    public init() { }
}


private extension SampleChartApp {
    var barChartButton: some View {
        NavigationLink(destination: BarChartSamples()) {
            getButton(with: "Bar Chart Samples")
        }
    }
    var lineChartButton: some View {
        NavigationLink(destination: LineChartSamples()) {
            getButton(with: "Line Chart Samples")
        }
    }
    var circularChartButton: some View {
        NavigationLink(destination: CircularChartSamples()) {
            getButton(with: "Circular Chart Samples")
        }
    }
    var pieChartButton: some View {
        NavigationLink(destination: PieChartSamples()) {
            getButton(with: "Pie Chart Samples")
        }
    }
    
    func getButton(with title: String) -> some View {
        Text(title)
            .foregroundColor(.orange)
            .fontWeight(.bold)
            .font(.title)
            .padding()
            .cornerRadius(16)
            .overlay(
                Capsule(style: .circular)
                    .stroke(Color.orange, style: StrokeStyle(lineWidth: 3)))
    }
}

struct SampleChartApp_Previews: PreviewProvider {
    static var previews: some View {
        SampleChartApp()
    }
}
