//
//  CircularChartSamples.swift
//  
//
//  Created by Berdil İlyada Karacam on 14.03.2021.
//

import SwiftUI

public struct CircularChartSamples: View {
    
    public var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .center, spacing: 24) {
                ForEach(CircularMockData().allMockModels) { (model) in
                    CircularChart(with: model)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 120)
                        .padding()
                }
            }
            .frame(width: UIScreen.main.bounds.width)
        }
        .navigationBarTitle("Circular Charts", displayMode: .inline)
        .padding([.bottom, .top])
    }
    
    public init() { }
}

struct CircularChartSamples_Previews: PreviewProvider {
    static var previews: some View {
        CircularChartSamples()
    }
}
