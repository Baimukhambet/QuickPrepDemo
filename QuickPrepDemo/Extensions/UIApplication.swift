import UIKit

extension UIApplication {
    static var screenSize: CGSize {
        return (UIApplication.shared.connectedScenes.first as! UIWindowScene).keyWindow!.bounds.size
    }
}

