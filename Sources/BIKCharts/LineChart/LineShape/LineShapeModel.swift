//
//  LineShapeModel.swift
//  Charts
//
//  Created by Berdil İlyada Karacam on 28.07.2020.
//  Copyright © 2020 Berdil İlyada Karacam. All rights reserved.
//

import SwiftUI

struct LineShapeModel {
    let data: [CGFloat]
    let shouldFill: Bool
    let calculationStyle: CalculationStyle
    
    init(data: [CGFloat], shouldFill: Bool, calculationStyle: CalculationStyle) {
        self.data = data
        self.shouldFill = shouldFill
        self.calculationStyle = calculationStyle
    }
}
