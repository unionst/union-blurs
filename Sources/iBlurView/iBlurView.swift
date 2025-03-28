//
//  iBlueView.swift
//  iBlurView
//
//  Created by Benjamin Sage on 3/8/25.
//

import SwiftUI
import UIKit

public struct iBlurView: View {
    public var radius: CGFloat = 20

    public init(radius: CGFloat) {
        self.radius = radius
    }

    public var body: some View {
        BlurView()
            .blur(radius: radius, opaque: true)
    }
}

#Preview {
    iBlurView(radius: 5)
}
