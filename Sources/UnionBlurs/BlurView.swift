//
//  BlurView.swift
//  union-blurs
//
//  Created by Ben Sage on 3/8/25.
//

import SwiftUI
import UIKit

public struct BlurView: View {
    public var radius: CGFloat

    public init(radius: CGFloat = 20) {
        self.radius = radius
    }

    public var body: some View {
        BackdropView()
            .blur(radius: radius, opaque: true)
    }
}

#Preview {
    BlurView(radius: 5)
}
