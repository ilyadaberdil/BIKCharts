//
//  PiePieceViewModel.swift
//  Charts
//
//  Created by Berdil İlyada Karacam on 1.08.2020.
//  Copyright © 2020 Berdil İlyada Karacam. All rights reserved.
//

import SwiftUI

//TODO: Add protocols implementation
struct PieSliceViewModel {
    var pieShapeViewModel: PieShapeViewModel
    var color: Color
    var textPosition: CGPoint = .zero
    var titleConfiguration: TitleConfiguration = TitleConfiguration()
}

struct TitleConfiguration {
    var title: String = ""
    var foregroundColor: Color = .white
    var font: Font = .headline
}
