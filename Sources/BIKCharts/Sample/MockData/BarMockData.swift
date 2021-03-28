//
//  BarMockData.swift
//  
//
//  Created by Berdil İlyada Karacam on 14.03.2021.
//

import SwiftUI

struct BarMockData {
    let sampleModel1 = BarChartModel(data: Mock().values,
                                     dataDescriptions: Mock().titles,
                                     calculationType: .maxValue,
                                     barSpacing: 16,
                                     fillBarColor: .green,
                                     emptyBarColor: .gray,
                                     barCornerRadius: .zero,
                                     showValueText: false,
                                     showValueDescription: true,
                                     isBadgeViewEnabled: true,
                                     badgeViewModel: .init(showUnderline: true, underlineColor: .red, title: "Değeri", foregroundColor: .purple),
                                     direction: .vertical)
    let sampleModel2 = BarChartModel(data: Array(Mock().values),
                                     dataDescriptions: Array(Mock().titles.prefix(3)),
                                     calculationType: .maxValue,
                                     barSpacing: 16,
                                     fillBarColor: .orange,
                                     emptyBarColor: .purple,
                                     barCornerRadius: 4,
                                     showValueText: false,
                                     showValueDescription: true,
                                     direction: .horizontal)
    let sampleModel3 = BarChartModel(data: Mock().values,
                                     dataDescriptions: Mock().titles,
                                     calculationType: .maxValue,
                                     barSpacing: 8,
                                     fillBarColor: .blue,
                                     emptyBarColor: .red,
                                     barCornerRadius: 8,
                                     showValueText: true,
                                     showValueDescription: false,
                                     direction: .vertical)
    let sampleModel4 = BarChartModel(data: Mock().values,
                                     dataDescriptions: Mock().titles,
                                     calculationType: .maxValue,
                                     barSpacing: 2,
                                     fillBarColor: .red,
                                     emptyBarColor: .gray,
                                     barCornerRadius: .zero,
                                     showValueText: true,
                                     showValueDescription: true,
                                     direction: .horizontal)
    
    var allMockModels: [BarChartModel] {
        return [sampleModel1, sampleModel2, sampleModel3, sampleModel4]
    }
}
