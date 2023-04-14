//
//  MapViewController.swift
//  Demo
//
//  Created by Krunal Patel on 14/04/23.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    let initialLocation = CLLocation(latitude: 23.0281, longitude: 72.4994)
    var routeOverlay : MKOverlay?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationAuth()
//        locationManager.requestWhenInUseAuthorization()
    }
    
    private func checkLocationPermission() {
        if CLLocationManager.locationServicesEnabled() {
            print("Location enabled")
            checkLocationAuth()
        } else {
            print("Loaction disabled")
        }
    }
    
    private func checkLocationAuth() {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            print("auth: notDetermined")
            locationManager.requestWhenInUseAuthorization()
            mapView.showsUserLocation = true
        case .restricted:
            print("auth: restricted")
        case .denied:
            print("auth: denied")
        case .authorizedAlways:
            print("auth: authorizedAlways")
        case .authorizedWhenInUse:
            print("auth: authorizedWhenInUse")
        }
        locationManager.delegate = self
        centerLocation()
//        cameraBoundary()
        addAnnotation()
    }
    
    private func centerLocation() {
        let region = MKCoordinateRegion(center: initialLocation.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(region, animated: true)
    }
    
    private func cameraBoundary() {
        let region = MKCoordinateRegion(center: initialLocation.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setCameraBoundary(MKMapView.CameraBoundary(coordinateRegion: region), animated: true)
        
        let cameraZoomRange = MKMapView.CameraZoomRange(minCenterCoordinateDistance: 500, maxCenterCoordinateDistance: 1000)
        mapView.setCameraZoomRange(cameraZoomRange, animated: true)
    }
    
    private func addAnnotation() {
        let annotation = MyAnnotation()
        annotation.coordinate = initialLocation.coordinate
    
        mapView.addAnnotation(annotation)
    }
    
    private func toogleRoute(show: Bool = true) {
        if show {
            MKPolyline(points: [MKMapPoint(initialLocation.coordinate), MKMapPoint(locationManager.location!.coordinate)], count: 2)
        }
    }
    
    func drawRoute(routeData: [CLLocation]) {
            if routeData.count == 0 {
                print("🟡 No Coordinates to draw")
                return
            }
            
            let coordinates = routeData.map { location -> CLLocationCoordinate2D in
                return location.coordinate
            }
            
            DispatchQueue.main.async {
                self.routeOverlay = MKPolyline(coordinates: coordinates, count: coordinates.count)
                self.mapView.addOverlay(self.routeOverlay!, level: .aboveRoads)
                let customEdgePadding : UIEdgeInsets = UIEdgeInsets(
                    top: 50,
                    left: 50,
                    bottom: 50,
                    right: 50
                )
                self.mapView.setVisibleMapRect(self.routeOverlay!.boundingMapRect, edgePadding: customEdgePadding,animated: true)
            }
        }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        print("heading updated: \(newHeading)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("location change: \(locations.description)")
    }
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print("auth change to \(manager.authorizationStatus)")
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        if let annotation = annotation as? MyAnnotation {
            let annotationView = MKAnnotationView()
            annotationView.canShowCallout = true
            let leftView = UIImageView(image: UIImage(named: "person"))
            annotationView.leftCalloutAccessoryView = leftView
            
            var contact = UILabel(frame: CGRectMake(0, 0, 100, 100))
            contact.numberOfLines = 0
            contact.text = "Name \nAddress \nContact Details"
            
            
            annotationView.detailCalloutAccessoryView = contact
            annotationView.image = UIImage(systemName: "location.north.fill")
            annotationView.tintColor = .red
            return annotationView
//        }
//        return nil
    }
    
    func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
        print("select annotation: \(annotation.description)")
        if let location = locationManager.location, annotation is MyAnnotation {
            mapView.preferredConfiguration.elevationStyle = .flat
            print(location)
            self.drawRoute(routeData: [initialLocation, location])
        }
    }
    
    func mapView(_ mapView: MKMapView, didDeselect annotation: MKAnnotation) {
        print("deselect annotation: \(annotation.title)")
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKGradientPolylineRenderer(overlay: overlay)
        
        renderer.setColors([
            UIColor(red: 0.02, green: 0.91, blue: 0.05, alpha: 1.0),
            UIColor(red: 1.0, green: 0.48, blue: 0.0, alpha: 1.0),
            UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0),
        ], locations: [])
        renderer.lineCap = .round
        renderer.lineWidth = 3.0
        
        return renderer
    }
    
}

class MyAnnotation: MKPointAnnotation {
    var imageName = UIImage(systemName: "location.north.fill")
}
