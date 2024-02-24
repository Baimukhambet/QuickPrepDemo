import UIKit

protocol OrderDetailDelegate {
    func trackButtonTapped()
}

final class OrderDetailsViewController: UIViewController, OrderDetailDelegate {
    weak var mainView: OrderDetailView! {
        return self.view as? OrderDetailView
    }
    
    let order: Order
    
    init(order: Order) {
        self.order = order
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = TitleView("Order Details")
        navigationItem.backButtonTitle = ""
        configureData()
    }
    
    override func loadView() {
        self.view = OrderDetailView(delegate: self)
    }
    
    func trackButtonTapped() {
        let trackVC = OrderTrackViewController()
        navigationController?.pushViewController(trackVC, animated: true)
    }

}

private extension OrderDetailsViewController {
    func configureData() {
        mainView.setData(id: order.id, image: UIImage(named: order.imageString)!, address: "99, Residency Rd, Shanthala Nagar, Ashok Nagar, Bengaluru, Karnataka 560025", date: "07/02/2024", time: "4:30 PM", title: order.title, subtotal: String(order.price - 57), total: String(order.price), taxes: "17", fee: "40")
    }
    

}
