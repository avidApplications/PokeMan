//
//  ViewController.swift
//  PokeMan
//
//  Created by Bradley Stovall on 5/25/17.
//  Copyright © 2017 Bradley Stovall. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var updateCount = 0
    
    var manager = CLLocationManager()
    
    var pokemans : [PokeMan] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokemans = getAllPokeMan()
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
        manager.delegate = self
        
        // User location access
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.delegate = self
            
            mapView.showsUserLocation = true
            manager.startUpdatingLocation()
            // Timer for PokeMan
            Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { (timer) in
                // Spawn for PokeMan
                if let coord = self.manager.location?.coordinate {
                    let anno = MKPointAnnotation()
                    anno.coordinate = coord
                    let randolat = (Double(arc4random_uniform(200)) - 100.0) / 50000.0
                    let randolon = (Double(arc4random_uniform(200)) - 100.0) / 50000.0
                    anno.coordinate.latitude += randolat
                    anno.coordinate.longitude += randolon
                    self.mapView.addAnnotation(anno)
                }
            })
            
            
        } else {
            
            manager.requestWhenInUseAuthorization()
        }
        
        
    }
    // Adding PokeMan images for each drop
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            let annoView = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
            annoView.image = UIImage(named: "player")
            var frame = annoView.frame
            frame.size.height = 50
            frame.size.width = 50
            annoView.frame = frame
            return annoView
        }
        
        let annoView = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
        annoView.image = UIImage(named: "mew")
        var frame = annoView.frame
        frame.size.height = 50
        frame.size.width = 50
        annoView.frame = frame
        return annoView
        
        
    }
    
    
    // Start with map zoomed in
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if updateCount < 5 {
            
            let region = MKCoordinateRegionMakeWithDistance(manager.location!.coordinate, 200, 200)
            mapView.setRegion(region, animated: false)
            updateCount += 1
        } else {
            manager.stopUpdatingLocation()
        }
        
        
    }
    // Compass Button
    @IBAction func centerTapped(_ sender: Any) {
        if (manager.location?.coordinate) != nil {
            let region = MKCoordinateRegionMakeWithDistance(manager.location!.coordinate, 200, 200)
            mapView.setRegion(region, animated: true)
        }
    }
    
}
