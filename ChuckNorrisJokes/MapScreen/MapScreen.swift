//
//  MapScreen.swift
//  ChuckNorrisJokes
//
//  Created by Юлия Кагирова on 11.07.2024.

import UIKit
import MapKit
import CoreLocation

class MapScreen: UIViewController {
    
    // MARK: - Properties
    
    var coordinator: Coordinator?
    var isButtonPressed = false
    var locationManager = CLLocationManager()
    var annotationSource: MKPointAnnotation?
    var annotationDestination: MKPointAnnotation?
    var segmentedControl: UISegmentedControl = {
        var titles = ["standart", "hybrid", "satellite"]
        var segContr = UISegmentedControl(items: titles)
        segContr.backgroundColor = .systemBackground
        segContr.translatesAutoresizingMaskIntoConstraints = false
        return segContr
    }()
    var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupButtons()
        checkAuthorization()
        //        checkLocationEnabled()
    }
    
    // MARK: - Private Methods
    
    private func setupButtons() {
        // deleteButton
        let deleteButton: UIButton = {
            let button = UIButton()
            button.setImage(UIImage(systemName: "xmark.bin"), for: .normal)
            button.addTarget(self, action: #selector(removeAnnotations), for: .touchUpInside)
            button.clipsToBounds = true
            button.layer.cornerRadius = 8
            button.backgroundColor = .systemBackground
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        
        //anchors
        view.addSubview(deleteButton)
        NSLayoutConstraint.activate([
            deleteButton.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 56),
            deleteButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -6),
            deleteButton.heightAnchor.constraint(equalToConstant: 42),
            deleteButton.widthAnchor.constraint(equalToConstant: 42)
        ])
        
        // rightBarButton
        let rightBarButton = UIBarButtonItem(
            image: UIImage(systemName: "mappin.and.ellipse"),
            style: .plain,
            target: self,
            action: #selector(switchButtonTapped))
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        // leftBarButton
        let leftBarButton = UIBarButtonItem(
            image: UIImage(systemName: "pencil.and.scribble"),
            style: .plain,
            target: self,
            action: #selector(createRoute))
        self.navigationItem.leftBarButtonItem = leftBarButton
        
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        title = "Map"
        view.addSubview(mapView)
        view.addSubview(segmentedControl)
        segmentedControl.addTarget(self, action: #selector(segmatedControlTapped(sender:)), for: .valueChanged)
        
        NSLayoutConstraint.activate([
            segmentedControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            segmentedControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            segmentedControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -52),
            segmentedControl.heightAnchor.constraint(equalToConstant: 42),
            
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
        locationManager.requestLocation()
        
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.showsUserTrackingButton = true
        print(mapView.userLocation)
        
        // longPressButton
        let lgr = UILongPressGestureRecognizer(target: self, action: #selector(longPress))
        mapView.addGestureRecognizer(lgr)
        
    }
    
    private func findRoute() {
        
        let source = annotationDestination?.coordinate
        let destination = annotationSource?.coordinate
        
        if (destination != nil) {
            print("no error in destination")
            print(destination!)
        } else {
            print( "destination is nil")
        }
        showRouteOnMap(annotationSource: source, annotationDestination: destination)
        print("find route tapped")
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "Attention",
                                      message: "Do you really want to delete all pins?",
                                      preferredStyle: .alert)
        // add two buttons
        let yes = UIAlertAction(title: "Yes", style: .destructive) { _ in
            print("Yes, delete all")
        }
        alert.addAction(yes)
        
        let no = UIAlertAction(title: "No", style: .default) { _ in
            print("no")
        }
        alert.addAction(no)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    private func showRouteOnMap(annotationSource: CLLocationCoordinate2D?, annotationDestination: CLLocationCoordinate2D?) {
        guard let annotationSource, let annotationDestination else  { return }
        
        //request
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: annotationSource))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: annotationDestination))
        request.transportType = .any
        
        //direction
        let direction = MKDirections(request: request)
        
        //calculate
        direction.calculate { [weak self] response, error in
            if let error {
                print(error)
                return
            }
            guard let unwrappedResponse = response else { return }
            //for getting just one route
            if let route = unwrappedResponse.routes.first {
                //show on map
                self?.mapView.addOverlay(route.polyline)
                //set the map area to show the route
                self?.mapView.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets.init(top: 80, left: 20, bottom: 100, right: 20), animated: true)
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: any MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline {
            let render = MKPolylineRenderer(overlay: overlay)
            render.strokeColor = .systemRed
            render.lineWidth = 5
            return render
        }
        return MKOverlayRenderer()
    }
    
    //    private func checkLocationEnabled() {
    //        if CLLocationManager.locationServicesEnabled() {
    //            checkAuthorization()
    //        } else {
    //            showAlertAction(title: "Your locations is off", message: "Do you want to change it?", url: URL(string: "App-Prefs:root=LOCATION_SERVICES"))
    //        }
    //    }
    
    private func checkAuthorization() {
        
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            locationManager.startUpdatingLocation()
            break
        case .restricted:
            break
        case .denied:
            showAlertAction(title: "Change you geo settings to track you", message: nil, url: URL(string: UIApplication.openSettingsURLString ))
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        default:
            print("Error")
        }
    }
    
    private func showAlertAction(title: String, message: String?, url: URL?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let settingsAction  = UIAlertAction(title: "Settings", style: .default) { (alert) in
            if let url = URL(string: "App-Prefs:root=LOCATION_SERVICES") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        let cancelAction = UIAlertAction(title: "No, keep it ", style: .destructive)
        alert.addAction(settingsAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    private func addAnnotation(coordinate: CLLocationCoordinate2D, title: String) {
        let annotation =  MyAnnotation(object: title)
        annotation.coordinate = coordinate
        annotation.title = title
        mapView.addAnnotation(annotation)
    }
    
    private func deleteAll() {
        for annotation in mapView.annotations {
            mapView.removeAnnotation(annotation)
        }
    }
    
    // MARK: - Event Handlers
    
    @objc private func segmatedControlTapped(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
            
        case 2:
            mapView.mapType = .satellite
            
        default:
            print("error")
            break
        }
    }
    
    @objc private func longPress(gesture: UILongPressGestureRecognizer) {
        let point = gesture.location(in: mapView)
        let location = mapView.convert(point, toCoordinateFrom: mapView)
        addAnnotation(coordinate: location, title: "You tapped me!")
        
        if annotationSource == nil {
            annotationSource = MKPointAnnotation()
            annotationSource?.coordinate = location
            annotationSource?.title = "Source"
            mapView.addAnnotation(annotationSource!)
        } else {
            annotationDestination = MKPointAnnotation()
            annotationDestination?.coordinate = location
            annotationDestination?.title = "Destination"
            mapView.addAnnotation(annotationDestination!)
        }
    }
    
    @objc private func createRoute() {
        findRoute()
    }
    
    @objc private func removeAnnotations(annotations: MKAnnotation) {
        showAlert()
        deleteAll()
    }
    
    @objc private func switchButtonTapped(isButtonPressed: Bool) {
        if !isButtonPressed {
            locationManager.requestWhenInUseAuthorization()
            self.isButtonPressed = true
            locationManager.startUpdatingLocation()
            print("start tracking")
        } else {
            self.isButtonPressed = false
            locationManager.stopUpdatingLocation()
            print("stop tracking")
        }
    }
}

class MyAnnotation: MKPointAnnotation {
    var object: String
    
    init(object: String) {
        self.object = object
    }
}

extension MapScreen: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            goToCenter(location: location)
            addAnnotation(coordinate: location.coordinate, title: Date.now.formatted())
        }
    }
    
    func goToCenter(location: CLLocation) {
        let center = CLLocationCoordinate2D(
            latitude: location.coordinate.latitude,
            longitude: location.coordinate.longitude
        )
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 100, longitudinalMeters: 100)
        mapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            isButtonPressed = true
            locationManager.startUpdatingLocation()
        default:
            isButtonPressed = false
            locationManager.startUpdatingLocation()
        }
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error: \(error)")
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkAuthorization()
    }
}

extension MapScreen: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let myAnnotation = view.annotation as? MyAnnotation {
            print(myAnnotation.object)
        }
    }
}
