import UIKit

final class TitleView: UILabel {

    init(_ title: String) {
        super.init(frame: .zero)
        self.text = title
        configure()
    }
    
    init(title: String) {
        super.init(frame: .zero)
        self.text = title
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.font = .montserat(ofSize: 24, weight: .semibold)
        self.textColor = .black
    }
    
}
