//
//  ChartSliceDataModel.swift
//  Charts
//
//  Created by Berdil İlyada Karacam on 1.08.2020.
//  Copyright © 2020 Berdil İlyada Karacam. All rights reserved.
//

import SwiftUI

struct ChartSliceDataModel {
    var value: CGFloat
    var color: Color?
    
    init(value: CGFloat, color: Color? = nil) {
        self.value = value
        self.color = color
    }
}
