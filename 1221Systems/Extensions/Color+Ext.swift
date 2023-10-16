import SwiftUI

extension Color {
    
    // TODO: Make as an init
    
    static func hex(_ hex: String) -> Self {
        let scanner = Scanner(string: hex)
        scanner.currentIndex = .init(utf16Offset: 0, in: hex)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        return Self.init(
            red: Double(r) / 0xff,
            green: Double(g) / 0xff,
            blue: Double(b) / 0xff,
            opacity: 1
        )
    }
}
