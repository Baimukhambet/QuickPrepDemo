import UIKit

final class StatusView: UIView {
    let screenSize = UIApplication.screenSize
    lazy var path1: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#4CAF50FF")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 4).isActive = true
        view.heightAnchor.constraint(equalToConstant: (screenSize.height / 2.5 - 240) / 2).isActive = true
        return view
    }()
    lazy var path2: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#E2EAE4FF")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 4).isActive = true
        view.heightAnchor.constraint(equalToConstant: (screenSize.height / 2.5 - 240) / 2).isActive = true
        
//        view.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
//        view.heightAnchor.constraint(equalToConstant: 10).isActive = true
//        view.clipsToBounds = true
        return view
    }()
    
    lazy var header: UILabel = {
        let label = UILabel()
        label.font = .montserat(ofSize: 18, weight: .semibold)
        label.textColor = UIColor(hex: "#1D1D1DFF")
        label.text = "Your order is on the way"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    lazy var timeTitle: UILabel = {
        let label = UILabel()
        label.font = .montserat(ofSize: 14, weight: .regular)
        label.textColor = UIColor(hex: "#1D1D1DFF")
        label.text = "Approximate time of delivery"
        return label
    }()
    
    lazy var time: UILabel = {
        let label = UILabel()
        label.font = .montserat(ofSize: 14, weight: .semibold)
        label.textColor = UIColor(hex: "#1D1D1DFF")
        label.text = "4:30 PM"
        return label
    }()
    
    lazy var timeStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [timeTitle, time])
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    init() {
        super.init(frame: .zero)
        self.backgroundColor = .systemBackground
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.layer.cornerRadius = 24

        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.addSubview(header)
        let headerTop = header.topAnchor.constraint(equalTo: self.topAnchor, constant: 32)
        NSLayoutConstraint.activate([
            headerTop,
            header.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            header.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
        ])
        headerTop.priority = UILayoutPriority(1000)
        
        self.addSubview(timeStackView)
        NSLayoutConstraint.activate([
            timeStackView.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 24),
            timeStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            timeStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
        ])
        
        let stack = createCheckmarks()
        self.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: timeStackView.bottomAnchor, constant: 24),
            stack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            stack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -60),
        ])
        

        
        let ordered = createLabel(text: "Ordered", color: UIColor(hex: "#1D1D1DFF")!, size: 14, weight: .medium)
        let ordVal = createLabel(text: "12:30, 7 Feb 2024", color: UIColor(hex: "#1D1D1DFF")!, size: 12, weight: .regular)
        
        let packed = createLabel(text: "Packed", color: UIColor(hex: "#1D1D1DFF")!, size: 14, weight: .medium)
        let pacVal = createLabel(text: "3:10, 7 Feb 2024", color: UIColor(hex: "#1D1D1DFF")!, size: 12, weight: .regular)
        
        let delivered = createLabel(text: "Delivered", color: UIColor(hex: "#1D1D1DFF")!, size: 14, weight: .medium)
        let delVal = createLabel(text: "Not delivered yet", color: UIColor(hex: "#1D1D1DFF")!, size: 12, weight: .regular)
        
        let s1 = createVStack(subviews: [ordered, ordVal])
        let s2 = createVStack(subviews: [packed, pacVal])
        let s3 = createVStack(subviews: [delivered, delVal])
        
        let finalSView = createVStack(subviews: [s1, s2, s3])
        finalSView.translatesAutoresizingMaskIntoConstraints = false
        finalSView.distribution = .equalSpacing
        self.addSubview(finalSView)
        NSLayoutConstraint.activate([
            finalSView.leadingAnchor.constraint(equalTo: stack.trailingAnchor, constant: 12),
            finalSView.topAnchor.constraint(equalTo: timeStackView.bottomAnchor, constant: 24),
            finalSView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50),
        ])

    }
    
    private func createCheckmarks() -> UIStackView {
        let mark1 = createMark()
        let mark2 = createMark()
        let mark3 = createEmptyMark()
        
        let stack = UIStackView(arrangedSubviews: [mark1, path1, mark2, path2, mark3])
        stack.axis = .vertical
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .center

        
        return stack
    }
    
    private func createMark() -> UIImageView {
        let imgView = UIImageView(image: UIImage(systemName: "checkmark.circle.fill")?.withTintColor(UIColor(hex: "#4CAF50FF")!, renderingMode: .alwaysOriginal))
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        return imgView
    }
    
    private func createEmptyMark() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#E2EAE4FF")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.widthAnchor.constraint(equalToConstant: 20).isActive = true
        view.heightAnchor.constraint(equalToConstant: 20).isActive = true
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return view
    }
    
    private func addPathToView(view: UIView, color: UIColor)  {
        let layer = CAShapeLayer()
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: view.center.x - 4, y: 0))
        path.addLine(to: CGPoint(x: view.center.x - 4, y: 120))
        path.lineWidth = 4
        
        layer.fillColor = color.cgColor
        layer.lineWidth = 4
        layer.path = path.cgPath
        
        view.layer.addSublayer(layer)
    }
    
    private func createLabel(text: String, color: UIColor, size: CGFloat, weight: UIFont.Weight) -> UILabel {
        let label = UILabel()
        label.font = .montserat(ofSize: size, weight: weight)
        label.text = text
        label.textColor = color
        
        return label
    }
    
    private func createVStack(subviews: [UIView]) -> UIStackView {
        let stack = UIStackView(arrangedSubviews: subviews)
        stack.axis = .vertical
        
        return stack
    }
    
}
