import SwiftUI

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
public struct InvisibleMaterial: View {
    public enum Style: Sendable {
        case ultraThin
        case thin
        case regular
        case thick
        case ultraThick
        case bar
        
        var blurRadius: CGFloat {
            switch self {
            case .ultraThin: return 1
            case .thin: return 3
            case .regular: return 8
            case .thick: return 20
            case .ultraThick: return 35
            case .bar: return 6
            }
        }
        
        var colorOpacity: Double {
            switch self {
            case .ultraThin: return 0.05
            case .thin: return 0.1
            case .regular: return 0.2
            case .thick: return 0.35
            case .ultraThick: return 0.5
            case .bar: return 0.15
            }
        }
    }
    
    private let style: Style
    @Environment(\.colorScheme) private var colorScheme
    
    public init(_ style: Style) {
        self.style = style
    }
    
    public var body: some View {
        ZStack {
            BlurView(radius: style.blurRadius)
            
            Rectangle()
                .fill(.background)
                .opacity(style.colorOpacity)
        }
    }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
public struct InvisibleMaterialShapeStyle: ShapeStyle, Sendable {
    fileprivate let style: InvisibleMaterial.Style
    
    init(_ style: InvisibleMaterial.Style) {
        self.style = style
    }
    
    public func resolve(in environment: EnvironmentValues) -> some ShapeStyle {
        let opacity = style.colorOpacity
        
        return BackgroundStyle()
            .opacity(opacity)
    }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
extension View {
    public func background<S: Shape>(_ material: InvisibleMaterialShapeStyle, in shape: S) -> some View {
        self.background {
            InvisibleMaterial(material.style)
                .clipShape(shape)
        }
    }
    
    public func background(_ material: InvisibleMaterialShapeStyle) -> some View {
        self.background {
            InvisibleMaterial(material.style)
        }
    }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
extension ShapeStyle where Self == InvisibleMaterialShapeStyle {
    public static var ultraThinInvisibleMaterial: InvisibleMaterialShapeStyle {
        InvisibleMaterialShapeStyle(.ultraThin)
    }
    
    public static var thinInvisibleMaterial: InvisibleMaterialShapeStyle {
        InvisibleMaterialShapeStyle(.thin)
    }
    
    public static var regularInvisibleMaterial: InvisibleMaterialShapeStyle {
        InvisibleMaterialShapeStyle(.regular)
    }
    
    public static var thickInvisibleMaterial: InvisibleMaterialShapeStyle {
        InvisibleMaterialShapeStyle(.thick)
    }
    
    public static var ultraThickInvisibleMaterial: InvisibleMaterialShapeStyle {
        InvisibleMaterialShapeStyle(.ultraThick)
    }
    
    public static var barInvisibleMaterial: InvisibleMaterialShapeStyle {
        InvisibleMaterialShapeStyle(.bar)
    }
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
#Preview("All Invisible Materials") {
    VStack(spacing: 20) {
        ForEach([
            ("Ultra Thin", InvisibleMaterial.Style.ultraThin),
            ("Thin", .thin),
            ("Regular", .regular),
            ("Thick", .thick),
            ("Ultra Thick", .ultraThick),
            ("Bar", .bar)
        ], id: \.0) { name, style in
            ZStack {
                Image(systemName: "photo.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 80)
                    .clipped()
                
                Text(name)
                    .font(.headline)
                    .foregroundStyle(.primary)
                    .padding()
                    .background(InvisibleMaterial(style))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
    }
    .padding()
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
#Preview("Shape Style Usage") {
    VStack(spacing: 20) {
        ZStack {
            LinearGradient(
                colors: [.blue, .purple],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            
            VStack(spacing: 16) {
                Label("Ultra Thin", systemImage: "1.circle")
                    .padding()
                    .background(.ultraThinInvisibleMaterial, in: RoundedRectangle(cornerRadius: 8))

                Label("Thin", systemImage: "2.circle")
                    .padding()
                    .background(.thinInvisibleMaterial, in: RoundedRectangle(cornerRadius: 8))
                
                Label("Regular", systemImage: "3.circle")
                    .padding()
                    .background(.regularInvisibleMaterial, in: RoundedRectangle(cornerRadius: 8))
                
                Label("Thick", systemImage: "4.circle")
                    .padding()
                    .background(.thickInvisibleMaterial, in: RoundedRectangle(cornerRadius: 8))
                
                Label("Ultra Thick", systemImage: "5.circle")
                    .padding()
                    .background(.ultraThickInvisibleMaterial, in: RoundedRectangle(cornerRadius: 8))
                
                Label("Bar", systemImage: "6.circle")
                    .padding()
                    .background(.barInvisibleMaterial, in: RoundedRectangle(cornerRadius: 8))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
