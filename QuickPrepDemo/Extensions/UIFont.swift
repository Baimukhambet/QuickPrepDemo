import UIKit

extension UIFont {
    static func montserat(ofSize fontSize: CGFloat, weight: UIFont.Weight) -> UIFont {
        switch weight {
        case .bold:
            guard let font = UIFont(name: "Montserrat-Bold", size: fontSize) else { return UIFont.italicSystemFont(ofSize: 45)}
            return font
        case .medium:
            guard let font = UIFont(name: "Montserrat-Medium", size: fontSize) else { return UIFont.italicSystemFont(ofSize: 45)}
            return font
        case .regular:
            guard let font = UIFont(name: "Montserrat-Regular", size: fontSize) else { return UIFont.italicSystemFont(ofSize: 45)}
            return font
        case .semibold:
            guard let font = UIFont(name: "Montserrat-SemiBold", size: fontSize) else { return UIFont.italicSystemFont(ofSize: 45)}
            return font
        default:
            guard let font = UIFont(name: "Montserrat-Regular", size: fontSize) else { return UIFont.italicSystemFont(ofSize: 45)}
            return font
        }
    }
}
