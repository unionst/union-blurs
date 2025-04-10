//
//  ProgressiveBlurView.swift
//  union-blurs
//
//  Created by Ben Sage on 7/14/24.
//

import SwiftUI
import CoreImage.CIFilterBuiltins
import QuartzCore

public enum VariableBlurDirection {
    case blurredTopClearBottom
    case blurredBottomClearTop
}

public struct ProgressiveBlurView: UIViewRepresentable {
    
    public var maxBlurRadius: CGFloat = 20
    public var direction: VariableBlurDirection = .blurredTopClearBottom
    
    /// By default, variable blur starts from 0 blur radius and linearly increases to `maxBlurRadius`. Setting `startOffset` to a
    /// small negative coefficient (e.g. -0.1) will start blur from larger radius value which might look better in some cases.
    public var startOffset: CGFloat = 0
    
    public func makeUIView(context: Context) -> ProgressiveBlurEffectView {
        ProgressiveBlurEffectView(
            maxBlurRadius: maxBlurRadius, direction: direction, startOffset: startOffset)
    }

    public func updateUIView(_ uiView: ProgressiveBlurEffectView, context: Context) { }
}

public class ProgressiveBlurEffectView: UIVisualEffectView {

    public init(
        maxBlurRadius: CGFloat = 20,
        direction: VariableBlurDirection = .blurredTopClearBottom,
        startOffset: CGFloat = 0
    ) {
        super.init(effect: UIBlurEffect(style: .regular))

        guard let CAFilter = NSClassFromString("CAFilter")! as? NSObject.Type else {
            print("[VariableBlur] Error: Can't find CAFilter class")
            return
        }
        guard let variableBlur = CAFilter.self.perform(
            NSSelectorFromString("filterWithType:"), with: "variableBlur"
        ).takeUnretainedValue() as? NSObject else {
            print("[VariableBlur] Error: CAFilter can't create filterWithType: variableBlur")
            return
        }

        let gradientImage = makeGradientImage(startOffset: startOffset, direction: direction)

        variableBlur.setValue(maxBlurRadius, forKey: "inputRadius")
        variableBlur.setValue(gradientImage, forKey: "inputMaskImage")
        variableBlur.setValue(true, forKey: "inputNormalizeEdges")

        let backdropLayer = subviews.first?.layer
        backdropLayer?.filters = [variableBlur]
        
        for subview in subviews.dropFirst() {
            subview.alpha = 0
        }
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func didMoveToWindow() {
        guard let window, let backdropLayer = subviews.first?.layer else { return }
        backdropLayer.setValue(window.screen.scale, forKey: "scale")
    }
    
    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) { }
    
    private func makeGradientImage(
        width: CGFloat = 100,
        height: CGFloat = 100,
        startOffset: CGFloat,
        direction: VariableBlurDirection
    ) -> CGImage {
        let ciGradientFilter =  CIFilter.linearGradient()
        ciGradientFilter.color0 = CIColor.black
        ciGradientFilter.color1 = CIColor.clear
        ciGradientFilter.point0 = CGPoint(x: 0, y: height)
        ciGradientFilter.point1 = CGPoint(x: 0, y: startOffset * height)
        if case .blurredBottomClearTop = direction {
            ciGradientFilter.point0.y = 0
            ciGradientFilter.point1.y = height - ciGradientFilter.point1.y
        }
        return CIContext().createCGImage(
            ciGradientFilter.outputImage!, from: CGRect(x: 0, y: 0, width: width, height: height))!
    }
}
