//
//  ProgressiveBlurView.swift
//  union-blurs
//
//  Created by Ben Sage on 7/14/24.
//

import SwiftUI

public struct ProgressiveBlurView: UIViewRepresentable {
    public var maxBlurRadius: CGFloat = 20
    public var direction: ProgressiveBlurDirection = .blurredTopClearBottom

    /// By default, variable blur starts from 0 blur radius and linearly increases to `maxBlurRadius`. Setting `startOffset` to a
    /// small negative coefficient (e.g. -0.1) will start blur from larger radius value which might look better in some cases.
    public var startOffset: CGFloat = 0
    
    public init(
        maxBlurRadius: CGFloat = 20,
        direction: ProgressiveBlurDirection = .blurredTopClearBottom,
        startOffset: CGFloat = 0
    ) {
        self.maxBlurRadius = maxBlurRadius
        self.direction = direction
        self.startOffset = startOffset
    }

    public func makeUIView(context: Context) -> ProgressiveBlurEffectView {
        ProgressiveBlurEffectView(
            maxBlurRadius: maxBlurRadius,
            direction: direction,
            startOffset: startOffset
        )
    }

    public func updateUIView(_ uiView: ProgressiveBlurEffectView, context: Context) { }
}
