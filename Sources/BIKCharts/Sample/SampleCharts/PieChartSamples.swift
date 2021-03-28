//
//  PieChartSamples.swift
//  
//
//  Created by Berdil İlyada Karacam on 14.03.2021.
//

import SwiftUI

public struct PieChartSamples: View {
    
    public var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .center, spacing: 24) {
                ForEach(PieMockData().allMockModels) { (model) in
                    PieChart(viewModel: model, tapAction: { (data) in
                        print(data)
                    })
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 250)
                    .padding()
                }
            }
            .frame(width: UIScreen.main.bounds.width)
        }
        .navigationBarTitle("Pie Charts", displayMode: .inline)
        .padding([.bottom, .top])
    }
    
    public init() { }
}

struct PieChartSamples_Previews: PreviewProvider {
    static var previews: some View {
        PieChartSamples()
    }
}
