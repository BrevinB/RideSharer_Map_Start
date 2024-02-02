//
//  MapViewController.swift
//  RideSharer
//
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //checkLocationServices()
            checkAuthorizationStatus()
    }
    
    func checkLocationServices() {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                self.checkAuthorizationStatus()
            } else {
                // Show alert letting the user know they have to turn this on.
            }
        }
    }
    
    func checkAuthorizationStatus() {
        switch locationManager.authorizationStatus {
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            break
        case .denied:// Show alert telling users how to turn on permissions
            let alertController = UIAlertController(title: "Turn Location preferences on", message: "", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            break
        case .notDetermined: 
            locationManager.requestWhenInUseAuthorization()
            mapView.showsUserLocation = true
            break
        case .restricted: // Show an alert letting them know what’s up
            let alertController = UIAlertController(title: "Location preferences have been restricted", message: "", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            break
        case .authorizedAlways: 
            mapView.showsUserLocation = true
            break
        default: 
            break
        }
    }
    
}
