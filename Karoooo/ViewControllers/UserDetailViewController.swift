//
//  UserDetailViewController.swift
//  Karoooo
//
//  Created by Raghvendra Pacholi on 18/12/22.
//

import Foundation
import UIKit
import MapKit

class UserDetailViewController: UIViewController, MKMapViewDelegate {
    
    // MARK: Properties
    var userDetailsViewModel :UserDetailsViewModel!
    
    // MARK: Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var currentCompanyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: Methods
    // Comments: Method to perform initial setup for view.
    private func setup() {
        self.navigationItem.title = userDetailsViewModel.name
        self.navigationController?.navigationBar.backgroundColor = .darkGray
        self.nameLabel.text = userDetailsViewModel.name
        self.emailLabel.text = userDetailsViewModel.email
        self.currentCompanyLabel.text = userDetailsViewModel.company.name
        self.phoneNumberLabel.text = userDetailsViewModel.phone
        self.mapView.mapType = MKMapType.standard
        self.mapView.isZoomEnabled = true
        self.mapView.isScrollEnabled = true
        
        self.mapView.center = view.center
        
        let center = CLLocationCoordinate2D(latitude: Double(self.userDetailsViewModel.address.geo.lat) ?? 0.0, longitude: Double(self.userDetailsViewModel.address.geo.lng) ?? 0.0)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.mapView.setRegion(region, animated: true)
        
        
        let myAnnotation: MKPointAnnotation = MKPointAnnotation()
        myAnnotation.coordinate = CLLocationCoordinate2DMake( Double(self.userDetailsViewModel.address.geo.lat) ?? 0.0, Double(self.userDetailsViewModel.address.geo.lng) ?? 0.0);
        myAnnotation.title = userDetailsViewModel.name
        self.mapView.addAnnotation(myAnnotation)
        
    }
    
}
