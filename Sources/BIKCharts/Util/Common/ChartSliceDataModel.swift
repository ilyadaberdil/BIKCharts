//
//  ChartSliceDataModel.swift
//  Charts
//
//  Created by Berdil İlyada Karacam on 1.08.2020.
//  Copyright © 2020 Berdil İlyada Karacam. All rights reserved.
//

import SwiftUI

public struct ChartSliceDataModel {
    let value: CGFloat
    let color: Color?
    
    public init(value: CGFloat, color: Color? = nil) {
        self.value = value
        self.color = color
    }
}
