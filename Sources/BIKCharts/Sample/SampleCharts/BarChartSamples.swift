//
//  BarChartSamples.swift
//
//  Created by Berdil İlyada Karacam on 13.03.2021.
//  Copyright © 2021 Berdil İlyada Karacam. All rights reserved.
//

import SwiftUI

public struct BarChartSamples: View {

    public var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .center, spacing: 16) {
                ForEach(BarMockData().allMockModels) { (model) in
                    BarChart(with: model, dragAction: { (value) in
                        print(value)
                    })
                    .frame(width: 350, height: 250)
                }
            }
            .frame(width: UIScreen.main.bounds.width)
        }
        .navigationBarTitle("Bar Charts", displayMode: .inline)
        .padding([.bottom, .top])
    }
    
    public init() { }
}

struct BarChartSamples_Previews: PreviewProvider {
    static var previews: some View {
        BarChartSamples()
    }
}
