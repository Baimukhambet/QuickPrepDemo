import UIKit

protocol OrderViewDelegate: UITableViewDataSource, UITableViewDelegate {
    
}

final class OrdersViewController: UIViewController, OrderViewDelegate {
    weak var mainView: OrdersView! {
        return self.view as? OrdersView
    }
    
    var orders: [Order] = [
        Order(id: "101", imageString: "meal", title: "Some meal", price: 532),
        Order(id: "101", imageString: "meal", title: "Some meal", price: 532),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationTitle()
    }
    
    override func loadView() {
        self.view = OrdersView(delegate: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mainView?.upcomingButton.addUnderline()
    }
    

}

//MARK: - Private functions
private extension OrdersViewController {
    func setupNavigationTitle() {
        self.navigationItem.backButtonTitle = ""
        self.navigationItem.titleView = TitleView(title: "My Orders")
    }
}


extension OrdersViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrderCardCell.description(), for: indexPath) as! OrderCardCell
        let order = orders[indexPath.section]
        cell.setData(image: UIImage(named: order.imageString)!, title: order.title, id: order.id, order.price)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(Int(UIApplication.screenSize.height / 6.7))
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 32))
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = OrderDetailsViewController(order: orders[indexPath.section])
        navigationController?.pushViewController(detailVC, animated: true)
    }
    

}
