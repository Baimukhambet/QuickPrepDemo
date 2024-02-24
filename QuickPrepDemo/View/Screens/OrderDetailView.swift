import UIKit

final class OrderDetailView: UIView {
    let delegate: OrderDetailDelegate
    enum constants {
        static let normalText = [NSAttributedString.Key.font : UIFont.montserat(ofSize: 14.0, weight: .regular), .foregroundColor : suppColor]
        static let boldText = [NSAttributedString.Key.font : UIFont.montserat(ofSize: 14.0, weight: .medium), .foregroundColor : mainColor]
        static let mainColor: UIColor = UIColor(hex: "#1D1D1DFF")!
        static let suppColor: UIColor = UIColor(hex: "#565656FF")!
    }
    
    //MARK: - Subviews
    lazy var orderIDLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    lazy var orderDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    lazy var topStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [orderIDLabel, orderDateLabel])
        stack.axis = .vertical
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
//
    lazy var orderImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.layer.cornerRadius = 10
        imgView.widthAnchor.constraint(equalToConstant: UIApplication.screenSize.width / 3.5).isActive = true
        imgView.clipsToBounds = true
        return imgView
    }()

    lazy var orderTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .montserat(ofSize: 18, weight: .semibold)
        label.textColor = constants.mainColor
        label.textAlignment = .left
        return label
    }()

    lazy var qtyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .montserat(ofSize: 14, weight: .regular)
        label.textColor = constants.suppColor
        label.textAlignment = .left
        return label
    }()
    
    lazy var mealPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .montserat(ofSize: 14, weight: .regular)
        label.textColor = constants.suppColor
        label.textAlignment = .left
        
        return label
    }()
    
    lazy var mealInfoStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [orderTitleLabel, qtyLabel, mealPriceLabel])
        stack.axis = .vertical
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var orderCardView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [orderImageView, mealInfoStackView])
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()

    lazy var orderTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .montserat(ofSize: 14, weight: .regular)
        label.textColor = constants.mainColor
        return label
    }()
    
    lazy var orderAddressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .montserat(ofSize: 14, weight: .regular)
        label.textColor = constants.mainColor
        label.numberOfLines = 0
        return label
    }()
    
    lazy var summaryLabel = generateLabel(text: "Order Summary", color: constants.mainColor, size: 18, weight: .semibold)
    
    lazy var trackButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Track Order", for: .normal)
        btn.backgroundColor = UIColor(hex: "#B82626FF")
        btn.layer.cornerRadius = UIApplication.screenSize.height / 28
        btn.setTitleColor(.white, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        btn.addAction(UIAction {[self] _ in delegate.trackButtonTapped()}, for: .touchUpInside)
        return btn
    }()
    
    //MARK: - Init
    init(delegate: OrderDetailDelegate) {
        self.delegate = delegate
        super.init(frame: .zero)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setData(id: String, image: UIImage, address: String, date: String, time: String, title: String, subtotal: String, total: String, taxes: String, fee: String) {
        orderIDLabel.attributedText = generateAttrString(title: "Order ID: ", value: id, trailSymbol: "")
        orderDateLabel.attributedText = generateAttrString(title: "Order Date: ", value: date, trailSymbol: "")
        
        orderImageView.image = image
        orderTitleLabel.text = title
        qtyLabel.text = "Qty: 3"
        mealPriceLabel.text = subtotal + "₸"
        
        orderTimeLabel.text = "Order will be delivered at \(time)"
        orderAddressLabel.text = address
        
        setupTotalView(generateHStackView(title: "Sub Total", value: subtotal + "₸", size: 14, weight: .medium), generateHStackView(title: "Taxes", value: taxes + "₸", size: 14, weight: .medium), generateHStackView(title: "Delivery fee", value: fee + "₸", size: 14, weight: .medium), generateHStackView(title: "Total", value: total + "₸", size: 16, weight: .semibold))
    }
    
}

//MARK: - Private functions
private extension OrderDetailView {
    func setup() {
        self.backgroundColor = .systemBackground
        setupTopView()
        setupMealView()
        setupDeliveryInfo()
        setupOrderSummaryView()
        setupButton()
    }
    
    func setupTopView() {
        self.addSubview(topStackView)
        NSLayoutConstraint.activate([
            topStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            topStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 32),
        ])
    }
    
    func setupMealView() {
        self.addSubview(orderCardView)
        NSLayoutConstraint.activate([
            orderCardView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            orderCardView.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: 24),
            orderCardView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            orderCardView.heightAnchor.constraint(equalToConstant: UIApplication.screenSize.height / 10)
        ])
    }
    
    func setupDeliveryInfo() {
        self.addSubview(orderTimeLabel)
        NSLayoutConstraint.activate([
            orderTimeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            orderTimeLabel.topAnchor.constraint(equalTo: orderCardView.bottomAnchor, constant: 22)
        ])
        
        let addressTitleLabel = generateLabel(text: "Delivery Address", color: constants.mainColor, size: 18, weight: .semibold)
        self.addSubview(addressTitleLabel)
        NSLayoutConstraint.activate([
            addressTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            addressTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            addressTitleLabel.topAnchor.constraint(equalTo: orderTimeLabel.bottomAnchor, constant: 32),
        ])
        
        self.addSubview(orderAddressLabel)
        NSLayoutConstraint.activate([
            orderAddressLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            orderAddressLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            orderAddressLabel.topAnchor.constraint(equalTo: addressTitleLabel.bottomAnchor, constant: 12)
        ])
    }
    
    func setupOrderSummaryView() {
        self.addSubview(summaryLabel)
        NSLayoutConstraint.activate([
            summaryLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            summaryLabel.topAnchor.constraint(equalTo: orderAddressLabel.bottomAnchor, constant: 32),
        ])
    }
    
    func setupTotalView(_ first: UIStackView, _ second: UIStackView, _ third: UIStackView, _ total: UIStackView) {
        let stack = UIStackView(arrangedSubviews: [first, second, third, total])
        stack.axis = .vertical
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.setCustomSpacing(16, after: third)
        
        self.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            stack.topAnchor.constraint(equalTo: summaryLabel.bottomAnchor, constant: 16),
        ])
    }
    
    func setupButton() {
        self.addSubview(trackButton)
        NSLayoutConstraint.activate([
            trackButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            trackButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            trackButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -40),
            trackButton.heightAnchor.constraint(equalToConstant: UIApplication.screenSize.height / 14)
        ])
    }
    
    func generateLabel(text: String, color: UIColor, size: CGFloat, weight: UIFont.Weight) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .montserat(ofSize: size, weight: weight)
        label.textColor = color
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }
    
    func generateAttrString(title: String, value: String, trailSymbol: String) -> NSAttributedString {
        let titleStr = NSMutableAttributedString(string: title, attributes: constants.normalText as [NSAttributedString.Key : Any])
        let valueStr = NSMutableAttributedString(string: value + trailSymbol, attributes: constants.boldText as [NSAttributedString.Key : Any])
        
        titleStr.append(valueStr)
        return titleStr
    }
    
    func generateHStackView(title: String, value: String, size: CGFloat, weight: UIFont.Weight) -> UIStackView {
        let stack = UIStackView()
        let titleLabel = generateLabel(text: title, color: constants.mainColor, size: size, weight: weight)
        let valueLabel = generateLabel(text: value, color: constants.mainColor, size: size, weight: weight)
        stack.axis = .horizontal
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(valueLabel)
        stack.distribution = .equalSpacing
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }
}


