//
//  MockData.swift
//  
//
//  Created by Berdil İlyada Karacam on 14.03.2021.
//
import SwiftUI

struct Mock {
    var points: [CGPoint] = [.init(x: 100, y: 0),
                             .init(x: 10, y: 0),
                             .init(x: 100, y: 100),
                             .init(x: 50, y: 250),
                             .init(x: 10, y: 0),
                             .init(x: 50, y: 250),
                             .init(x: 10, y: 152),
                             .init(x: 50, y: 500),
                             .init(x: 10, y: 52),
                             .init(x: 10, y: 25),
                             .init(x: 100, y: 100),
                             .init(x: 50, y: 44),
                             .init(x: 10, y: 24),
                             .init(x: 50, y: 120),
                             .init(x: 10, y: 92),
                             .init(x: 50, y: 36)]
    var values: [CGFloat] = [300, 300, 400, 800, 1500, 400, 300, 800, 2000, 144, 53, 77]
    var titles: [String] = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
}
