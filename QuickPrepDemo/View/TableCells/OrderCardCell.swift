import UIKit

final class OrderCardCell: UITableViewCell {
    enum constants {
        static let normalText = [NSAttributedString.Key.font : UIFont.montserat(ofSize: 14.0, weight: .regular), .foregroundColor : UIColor(hex: "#565656FF")]
        static let boldText = [NSAttributedString.Key.font : UIFont.montserat(ofSize: 14.0, weight: .medium), .foregroundColor : UIColor(hex: "#1D1D1DFF")]
    }
    
    lazy var imageCard: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.layer.cornerRadius = 10
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.clipsToBounds = true
        return imgView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .montserat(ofSize: 18, weight: .semibold)
        label.textColor = .init(hex: "#1D1D1DFF")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var idLabel: UILabel = {
        let label = UILabel()
        label.font = .montserat(ofSize: 14, weight: .regular)
        label.textColor = .init(hex: "#565656FF")
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .montserat(ofSize: 14, weight: .regular)
        label.textColor = .init(hex: "#565656FF")
        return label
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = .montserat(ofSize: 14, weight: .regular)
        label.textColor = .init(hex: "#565656FF")
        return label
    }()
    
    lazy var infoStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [idLabel, priceLabel, timeLabel])
        stack.axis = .vertical
        stack.spacing = 6
        stack.distribution = .fillProportionally
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let backView = UIView()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        backView.backgroundColor = .clear
        self.selectedBackgroundView = backView
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.backgroundColor = .white
        self.backgroundColor = .clear
        contentView.layer.cornerRadius = 17
        
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowRadius = 4
        contentView.layer.shadowOpacity = 0.1
        contentView.layer.shadowOffset = CGSize(width: 0, height: 4)
        
        setupImageView()
        setupTitleLabel()
        setupStackView()
    }
    
    private func setupImageView() {
        let hAnch = imageCard.heightAnchor
        let wAnch = imageCard.widthAnchor
        contentView.addSubview(imageCard)
        NSLayoutConstraint.activate([
            imageCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            imageCard.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            imageCard.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            wAnch.constraint(equalTo: hAnch)
        ])
    }
    
    private func setupStackView() {
        self.addSubview(infoStackView)
        NSLayoutConstraint.activate([
            infoStackView.leadingAnchor.constraint(equalTo: imageCard.trailingAnchor, constant: 16),
            infoStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
//            infoStackView.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 16),
            infoStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
        ])
    }
    
    private func setupTitleLabel() {
        self.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: imageCard.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8)
        ])
    }
    
    func setData(image: UIImage, title: String, id: String, _ paymentAmount: Int) {
        imageCard.image = image
        titleLabel.text = title
        idLabel.attributedText = generateAttrString(title: "Order ID: ", value: id, trailSymbol: "")
        priceLabel.attributedText = generateAttrString(title: "Amount Paid: ", value: String(paymentAmount), trailSymbol: "₸")
        timeLabel.text = "To be delivered at 4:30 PM"
    }
    
    private func generateAttrString(title: String, value: String, trailSymbol: String) -> NSAttributedString {
        let titleStr = NSMutableAttributedString(string: title, attributes: constants.normalText as [NSAttributedString.Key : Any])
        let valueStr = NSMutableAttributedString(string: value + trailSymbol, attributes: constants.boldText as [NSAttributedString.Key : Any])
        
        titleStr.append(valueStr)
        return titleStr
    }
    
}
