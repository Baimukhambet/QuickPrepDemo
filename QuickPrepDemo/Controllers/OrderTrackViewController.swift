import UIKit
import GoogleMaps
import SwiftyJSON

final class OrderTrackViewController: UIViewController {
    var locationManager = CLLocationManager()
    let mapView = GMSMapView()
    
    //51.123083° 71.421598°
    let srcLocation = CLLocationCoordinate2D(latitude: 51.123083, longitude: 71.421598)
    
    //51.11261° 71.426609°
    let destLocation = CLLocationCoordinate2D(latitude: 51.11261, longitude: 71.426609)
    
    let info = StatusView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestWhenInUseAuthorization()
        setupView()
        
        let url = createUrl(source: srcLocation, destination: destLocation)
        setPolyline(url: url)
        
        self.view.addSubview(info)
        NSLayoutConstraint.activate([
            info.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            info.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            info.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            info.heightAnchor.constraint(equalToConstant: view.bounds.size.height / 2.5)
        ])
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
}

private extension OrderTrackViewController {
    func setupView() {
        self.view.backgroundColor = .systemBackground
        setupMapView()
        navigationItem.titleView = TitleView("Order Tracking")
    }
    
    func setupMapView() {
        let camera = GMSCameraPosition.camera(withLatitude: destLocation.latitude, longitude: destLocation.longitude, zoom: 15.0)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.camera = camera
        mapView.delegate = self
        self.view.addSubview(mapView)
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = srcLocation
        marker.title = "SF"
        let iconView = UIImageView(image: UIImage(named: "sfSymbol"))
        iconView.contentMode = .scaleAspectFill
        iconView.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        marker.iconView = iconView
        marker.map = mapView
        
        let destMarker = GMSMarker()
        destMarker.position = destLocation
        destMarker.title = "User"
        destMarker.map = mapView
        
    }
    
    func createUrl(source: CLLocationCoordinate2D, destination: CLLocationCoordinate2D) -> String {
        let src = "\(source.latitude) , \(source.longitude)"
        let dest = "\(destination.latitude) , \(destination.longitude)"
        
        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(src)&destination=\(dest)&mode=driving&key=AIzaSyAK-63-7Wx2p-1p8hlOyNF8qg2RHVkZWuI"
        return url
    }
    
    func setPolyline(url: String) {
        URLSession.shared.dataTask(with: URLRequest(url: URL(string: url)!)) { data, response, error in
            if let data = data {
                
                if let jsonData = try? JSON(data: data) {
                    DispatchQueue.main.async {
                        let routes = jsonData["routes"].arrayValue
                        for route in routes {
                            let overviewPolyline = route["overview_polyline"].dictionary
                            let points = overviewPolyline?["points"]?.string
                            let path = GMSPath(fromEncodedPath: points ?? "")
                            let polyline = GMSPolyline(path: path)
                            polyline.strokeColor = .systemBlue
                            polyline.strokeWidth = 5
                            polyline.map = self.mapView
                        }
                    }
                } else {
                    print("Error")
                    return
                }
            } else {
                print("ERRROR")
            }
            
        }.resume()
    }
    
    func presentStatusSheet() {
        let statusVC = OrderStatusSheetController()
        self.present(statusVC, animated: true)
    }
    
}

extension OrderTrackViewController: GMSMapViewDelegate {
    
}
