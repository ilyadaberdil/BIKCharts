//
//  GeometryProxy+Extension.swift
//  Charts
//
//  Created by Berdil İlyada Karacam on 30.07.2020.
//  Copyright © 2020 Berdil İlyada Karacam. All rights reserved.
//

import SwiftUI

extension GeometryProxy {
    var width: CGFloat {
        size.width
    }
    
    var height: CGFloat {
        size.height
    }
    
    var center: CGPoint {
        .init(x: width/2, y: height/2)
    }
}
