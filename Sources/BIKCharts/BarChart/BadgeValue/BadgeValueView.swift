//
//  BadgeValueView.swift
//  Charts
//
//  Created by Berdil İlyada Karacam on 6.12.2020.
//  Copyright © 2020 Berdil İlyada Karacam. All rights reserved.
//

import SwiftUI

struct BadgeValueView: View {
    @Binding var value: CGFloat
    var direction: BarChartDirection
    
    var body: some View {
        ZStack {
            BadgeShape()
                .foregroundColor(.red)
                .cornerRadius(35)
                .rotationEffect(direction == .vertical ? .degrees(90) : .zero)
            infoText
        }
    }
    
    var infoText: some View {
        VStack {
            //TODO: Make this text Bindable like value prop
            Text("Value")
                .underline()
                .multilineTextAlignment(.center)
                .font(.system(size: 10))
            Text("\(String(format: "%.1f", value))")
                .multilineTextAlignment(.center)
                .font(.system(size: 10))
        }.padding()
    }
}
