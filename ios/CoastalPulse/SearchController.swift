//
//  ViewController.swift
//  CoastalPulse
//
//  Created by Δήμητρα Μαλλιαρου on 22/4/23.
//

import UIKit
import MapboxMaps
import MapboxCommon
import MapboxCoreMaps
import MapboxMobileEvents
import CoreLocation

class SearchController: UIViewController, UISearchBarDelegate {

    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var mapView: UIView!
    internal var streetMap: MapView!
    let geoCoder = CLGeocoder()    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tabBarItem.image = tabBarItem.image?.withRenderingMode(.alwaysOriginal)
        tabBarItem.selectedImage = tabBarItem.selectedImage?.withRenderingMode(.alwaysOriginal)
        
        searchBar.searchTextField.backgroundColor = UIColor(red: 0.68, green: 0.85, blue: 0.90, alpha: 1.00)
        searchBar.barTintColor = .clear
        searchBar.backgroundColor = UIColor.clear
        searchBar.isTranslucent = true
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        
        let myResourceOptions = ResourceOptions(accessToken: "pk.eyJ1IjoiZGltaW1hbGwiLCJhIjoiY2xncnQwcm8yMDhjbTNmb2N4OHhsemNidiJ9.WHUna0xh7mDL4eMWC8s42Q")
        let myMapInitOptions = MapInitOptions(resourceOptions: myResourceOptions)
        streetMap = MapView(frame: mapView.bounds, mapInitOptions: myMapInitOptions)
        streetMap.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.mapView.addSubview(streetMap)
        
        streetMap.location.delegate = self
        
        streetMap.location.requestTemporaryFullAccuracyPermissions(withPurposeKey: "CustomKey")
        streetMap.location.options.puckType = .puck2D()
        
        searchBar.delegate = self
        
    }
    
    func presentModalController() {
        let vc = CustomModalViewController()
        vc.modalPresentationStyle = .overCurrentContext
        // Keep animated value as false
        // Custom Modal presentation animation will be handled in VC itself
        vc.textFirstLabel = "Θεσσαλία"
        self.present(vc, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("searchText \(searchText)")
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let input = searchBar.text {
            self.handleTapGestureRecognizer()
            getCordinatesLocation(address: input)
        }
    }
    
    func getCordinatesLocation(address:String){
        geoCoder.geocodeAddressString(address) { (placemarks, error) in
            if let placemarks = placemarks {
                
                self.streetMap.removeFromSuperview()
                
                let location = placemarks.first?.location
                print("location \(Double((location?.coordinate.latitude)!)) \(Double((location?.coordinate.longitude)!))")
                let options = MapInitOptions(cameraOptions: CameraOptions(center: location?.coordinate, zoom: 13,bearing: -17.6,pitch: 45))
                 
                self.streetMap = MapView(frame: self.mapView.bounds, mapInitOptions: options)
                self.streetMap.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                self.mapView.addSubview(self.streetMap)
                
                self.streetMap.mapboxMap.style.uri = .streets
                
                let tapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                  action: #selector(self.handleTapGestureRecognizer))
                self.streetMap.addGestureRecognizer(tapGestureRecognizer)
                
            }
            else {
                // handle no location found
                print("Location not found")
                return
            }
            // Use your location
        }
    }
    
    @objc func handleTapGestureRecognizer() {
        self.presentModalController()
    }
}
extension SearchController: LocationPermissionsDelegate {
    func locationManager(_ locationManager: LocationManager, didChangeAccuracyAuthorization accuracyAuthorization: CLAccuracyAuthorization) {
        if accuracyAuthorization == .reducedAccuracy {
         // Perform an action in response to the new change in accuracy
        }
    }
}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
