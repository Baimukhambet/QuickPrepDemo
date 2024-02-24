import UIKit

final class CustomButton: UIButton {
    lazy var underlineLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.fillColor = UIColor(hex: "#B82626FF")?.cgColor
        return layer
    }()
    
    var wholeSize: CGSize?
    
    init() {
        super.init(frame: .zero)
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        print(self.frame)
//    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addUnderline() {
        let inSize = self.intrinsicContentSize
        let size = self.bounds.size
        let inset = (size.width - inSize.width) / 2
        let path = UIBezierPath(roundedRect: CGRect(x: inset, y: size.height - 4, width: inSize.width, height: 4), cornerRadius: 4)
        underlineLayer.path = path.cgPath
        self.layer.addSublayer(underlineLayer)
    }
    
    func removeUnderline() {
        underlineLayer.removeFromSuperlayer()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.wholeSize = self.bounds.size
    }
    
}
