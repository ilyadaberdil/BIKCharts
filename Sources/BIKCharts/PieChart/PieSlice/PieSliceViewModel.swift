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

public struct TitleConfiguration {
    let title: String
    let foregroundColor: Color
    let font: Font
    
    public init(title: String = "", foregroundColor: Color = .white, font: Font = .headline) {
        self.title = title
        self.foregroundColor = foregroundColor
        self.font = font
    }
}
