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
    var shouldTrim: Bool
    var trim: (from: CGFloat, to: CGFloat)
    var rotationDegree: Double
    var padding: CGFloat
    var color: Color
    var strokeStyle: StrokeStyle
}
