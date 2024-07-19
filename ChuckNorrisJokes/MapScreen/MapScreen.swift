//
//  MapScreen.swift
//  ChuckNorrisJokes
//
//  Created by Юлия Кагирова on 11.07.2024.
//

import UIKit
import MapKit
import CoreLocation

class MapScreen: UIViewController {
    
    // MARK: - Properties
    
    var coordinator: Coordinator?
    var titles = ["standart", "hybrid", "satellite"]
    var segmentedControl: UISegmentedControl!
    var mapView: MKMapView = {
        let mapView = MKMapView()
        return mapView
    }()
    let locationManager = CLLocationManager()
    var annotationSource: MKPointAnnotation?
    var annotationDestination: MKPointAnnotation?
    var annotations: [MKAnnotation] = []
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupButtons()
        //        switchButtonTapped(isButtonPressed: true)
        
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
    
    override func viewDidAppear(_ animated: Bool) {
        let center = CLLocationCoordinate2D(latitude: 55.75658377674119, longitude: 37.61729168657163)
        let region = MKCoordinateRegion(center: center , latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
        addAnnotation(coordinate: center, title: "Moscow")
    }
    
    // MARK: - Private Methods
    
    private func setupButtons() {
        // deleteButton
        let deleteButton: UIButton = {
            let button = UIButton()
            button.setImage(UIImage(systemName: "xmark.bin"), for: .normal)
            button.addTarget(self, action: #selector(removeAnnotations), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        
        view.addSubview(deleteButton)
        NSLayoutConstraint.activate([
            deleteButton.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 50),
            deleteButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor),
            deleteButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        title = "Map"
        view.addSubview(mapView)
        view.addSubview(segmentedControl)
        segmentedControl = UISegmentedControl(items: titles)
        segmentedControl.addTarget(self, action: #selector(segmatedControlTapped(sender:)), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
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
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.showsUserTrackingButton = true
        
        // longPressButton
        let lgr = UILongPressGestureRecognizer(target: self, action: #selector(longPress))
        mapView.addGestureRecognizer(lgr)
       
    }
    
    private func findRoute() {
        
        //create two locations
//        let loc1 = CLLocationCoordinate2D.init(latitude: 40.741895, longitude: -73.989308) //annotationSource?.coordinate
        let loc2 = CLLocationCoordinate2D.init(latitude: 40.728448, longitude: -73.717996)//annotationDestination?.coordinate
        
        let currentPoint = CLLocationCoordinate2D(latitude: 55.75658377674119, longitude: 37.61729168657163)
//        let destination = annotationDestination?.coordinate
        
        //find route
        showRouteOnMap(annotationSource: currentPoint, annotationDestination: loc2)
        
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
        request.requestsAlternateRoutes = true
        request.transportType = .automobile
        
        //direction
        let direction = MKDirections(request: request)
        
        //calculate
        direction.calculate { [weak self] response, error in
            guard let unwrappedResponse = response else { return }
            //for getting just one route
            if let route = unwrappedResponse.routes.first {
                //show on map
                self?.mapView.addOverlay(route.polyline)
                //set the map area to show the route
                self?.mapView.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets.init(top: 80.0, left: 20.0, bottom: 100.0, right: 20.0), animated: true)
            }
        }
        
        //drow route
        func mapView(_ mapView: MKMapView, rendererFor overlay: any MKOverlay) -> MKOverlayRenderer {
            if overlay is MKPolyline {
                let render = MKPolylineRenderer(overlay: overlay)
                render.strokeColor = .systemRed
                render.lineWidth = 5
                return render
            }
            return MKOverlayRenderer()
        }
    }
    
    // MARK: - Methods
    
    func addAnnotation(coordinate: CLLocationCoordinate2D, title: String) {
        let annotation =  MyAnnotation(object: title)//MKPointAnnotation()
        annotation.coordinate = coordinate // CLLocationCoordinate2D(latitude: 55.75658377674119, longitude: 37.61729168657163)
        annotation.title = title //"Москва. Центр."
        mapView.addAnnotation(annotation)
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
    
//    @objc private func doubleClick(gesture: UITapGestureRecognizer) {
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(removeAnnotations))
//        tapGesture.numberOfTapsRequired = 3
//        mapView.isUserInteractionEnabled = true
//        mapView.addGestureRecognizer(tapGesture)
//
//    }
    
    @objc private func createRoute() {
        findRoute()
    }

   @objc private func removeAnnotations(annotations: MKAnnotation) {
       showAlert()
//        mapView.removeAnnotations(annotations as! [any MKAnnotation])
    }
    
    @objc private func switchButtonTapped(isButtonPressed: Bool) {
        let isButtonPressed = !isButtonPressed
        switch isButtonPressed {
        case true:
            locationManager.delegate = self
            locationManager.startUpdatingLocation()
            locationManager.startMonitoringSignificantLocationChanges()
            print("start tracking")
            
        case false:
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            locationManager.stopMonitoringSignificantLocationChanges()
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
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 100, longitudinalMeters: 100)
        mapView.setRegion(region, animated: true)
    }
}

extension MapScreen: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let myAnnotation = view.annotation as? MyAnnotation {
            print(myAnnotation.object)
        }
    }
}
