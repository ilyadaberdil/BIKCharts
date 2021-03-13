//
//  CircularSliceModel.swift
//  Charts
//
//  Created by Berdil İlyada Karacam on 30.07.2020.
//  Copyright © 2020 Berdil İlyada Karacam. All rights reserved.
//

import Foundation
import SwiftUI

struct CircularSliceModel {
    let shouldTrim: Bool
    let trim: (from: CGFloat, to: CGFloat)
    let rotationDegree: Double
    let padding: CGFloat
    let color: Color
    let strokeStyle: StrokeStyle
}
