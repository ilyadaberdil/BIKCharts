//
//  View+Extension.swift
//  Charts
//
//  Created by Berdil İlyada Karacam on 30.07.2020.
//  Copyright © 2020 Berdil İlyada Karacam. All rights reserved.
//

import SwiftUI

extension View {
    func animateOnAppear(using animation: Animation = Animation.easeInOut(duration: 1),
                         delay: Double = 0.3,
                         _ action: @escaping () -> Void) -> some View {
        return onAppear {
            withAnimation(animation.delay(delay)) {
                action()
            }
        }
    }
    
    func animateForeverOnAppear(using animation: Animation = Animation.easeInOut(duration: 1), autoreverses: Bool = false, _ action: @escaping () -> Void) -> some View {
        let repeated = animation.repeatForever(autoreverses: autoreverses)
        
        return onAppear {
            withAnimation(repeated) {
                action()
            }
        }
    }
}
