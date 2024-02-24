import UIKit

final class OrdersView: UIView {
    private let delegate: OrderViewDelegate
    var currentViewSegment: Int = 0
    
    enum constants {
        static let buttonActiveColor: UIColor = UIColor(hex: "#B82626FF")!
        static let buttonInactiveColor: UIColor = UIColor(hex: "#7E7E7EFF")!
        static let backgroundColor: UIColor = UIColor(hex: "#FAFAFAFF")!
    }
    
    //MARK: - Subviews
    lazy var upcomingButton: CustomButton = {
        let button = CustomButton()
        button.setTitle("Upcoming Orders", for: .normal)
            button.setTitleColor(constants.buttonActiveColor, for: .normal)
        button.titleLabel?.font = .montserat(ofSize: 16, weight: .semibold)
        button.addAction(UIAction{_ in self.segmentButtonTapped(0)}, for: .touchUpInside)
        return button
    }()
    lazy var pastButton: CustomButton = {
        let button = CustomButton()
        button.setTitle("Past Orders", for: .normal)
        button.setTitleColor(constants.buttonInactiveColor, for: .normal)
        button.titleLabel?.font = .montserat(ofSize: 16, weight: .medium)
        button.addAction(UIAction{_ in self.segmentButtonTapped(1)}, for: .touchUpInside)
        return button
    }()
    
    lazy var segmentedButtonStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        
        stack.addArrangedSubview(upcomingButton)
        stack.addArrangedSubview(pastButton)
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = delegate
        tableView.delegate = delegate
        tableView.register(OrderCardCell.self, forCellReuseIdentifier: OrderCardCell.description())
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = constants.backgroundColor
        
        return tableView
    }()
    
    init(delegate: OrderViewDelegate) {
        self.delegate = delegate
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

//MARK: - Private functions
private extension OrdersView {
    func setup() {
        self.backgroundColor = constants.backgroundColor
        setupSegmentButtons()
        setupTableView()
    }
    
    func setupSegmentButtons() {
        self.addSubview(segmentedButtonStack)
        NSLayoutConstraint.activate([
            segmentedButtonStack.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 24),
            segmentedButtonStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 44),
            segmentedButtonStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -44),
        ])
    }
    
    func setupTableView() {
        self.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: segmentedButtonStack.bottomAnchor, constant: 24),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
   
    func segmentButtonTapped(_ index: Int) {
        if index != currentViewSegment {
            currentViewSegment = index
            if index == 1 {
                upcomingButton.removeUnderline()
                pastButton.addUnderline()
                
                pastButton.setTitleColor(constants.buttonActiveColor, for: .normal)
                upcomingButton.setTitleColor(constants.buttonInactiveColor, for: .normal)
            } else {
                pastButton.removeUnderline()
                upcomingButton.addUnderline()
                
                upcomingButton.setTitleColor(constants.buttonActiveColor, for: .normal)
                pastButton.setTitleColor(constants.buttonInactiveColor, for: .normal)
            }
        }
    }
}
