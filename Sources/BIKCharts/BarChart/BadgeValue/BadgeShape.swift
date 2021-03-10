//
//  BadgeShape.swift
//  Charts
//
//  Created by Berdil İlyada Karacam on 6.12.2020.
//  Copyright © 2020 Berdil İlyada Karacam. All rights reserved.
//

import SwiftUI

struct BadgeShape: Shape {
    private enum Const {
        static let triangleSize: CGFloat = 20
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY-Const.triangleSize/2))
        path.addLine(to: CGPoint(x: rect.midX+Const.triangleSize/2, y: rect.maxY-Const.triangleSize/2))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX-Const.triangleSize/2, y: rect.maxY-Const.triangleSize/2))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY-Const.triangleSize/2))

        return path
    }
}
