import UIKit

class OrderStatusSheetController: UIViewController, UISheetPresentationControllerDelegate {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sheetPresentationController?.detents = [
            .medium()
        ]
        setup()
        
    }
    

    private func setup() {
        self.view.backgroundColor = .systemBackground
    }

}
