//
//  iBlueView.swift
//  UnionBlur
//
//  Created by Benjamin Sage on 3/8/25.
//

import SwiftUI
import UIKit

public struct BlurView: View {
    public var radius: CGFloat = 20

    public init(radius: CGFloat) {
        self.radius = radius
    }

    public var body: some View {
        BlurViewRepresentable()
            .blur(radius: radius, opaque: true)
    }
}

#Preview {
    BlurView(radius: 5)
}
