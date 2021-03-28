//
//  LineChartSamples..swift
//  
//
//  Created by Berdil İlyada Karacam on 14.03.2021.
//

import SwiftUI

public struct LineChartSamples: View {

    public var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .center, spacing: 24) {
                ForEach(LineMockData().allMockModels) { (model) in
                    LineChart(with: model)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 120)
                        .padding()
                }
            }
            .frame(width: UIScreen.main.bounds.width)
        }
        .navigationBarTitle("Line Charts", displayMode: .inline)
        .padding([.bottom, .top])
    }
    
    public init() { }
}

struct LineChartSamples_Previews: PreviewProvider {
    static var previews: some View {
        LineChartSamples()
    }
}
