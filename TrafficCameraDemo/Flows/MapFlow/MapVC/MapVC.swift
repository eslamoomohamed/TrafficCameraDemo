//
//  MapVC.swift
//  TrafficCameraDemo
//
//  Created by eslam mohamed on 07/07/2022.
//

import UIKit
import MapKit

class MapVC: UIViewController, StoryboardLoad {

    weak var coordinator: Coordinator?
    private var viewModel:MapViewModel! = MapViewModel()
    @IBOutlet weak var traficMapView: MKMapView!
    
    var onOnnotationTap:((AnnotaionsViewModel)->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assert(viewModel != nil, "ViewModel cannot be nil")
        openMapForPlace()
        bindViewModel()
        viewModel.fetchData()
    }
    
    private func bindViewModel(){
        updateViewWithLoadingView()
        updateViewWithData()
    }
    
    private func updateViewWithLoadingView(){
        guard let viewModel         = viewModel else { return }
        viewModel.showLoadingToView = { DispatchQueue.main.async { self.showLoadingView() } }
        viewModel.hideLoadingToView = { DispatchQueue.main.async { self.removeLoadingView() } }
    }

    func updateViewWithData(){
        guard let viewModel = viewModel else { return }
        viewModel.updateMapViewClosure = { DispatchQueue.main.async { self.drawAnnotaionOnMap() } }
    }
    
    func drawAnnotaionOnMap(){
        for i in 0..<viewModel.numberOfAnnotaion{
            let annotaion         = viewModel.getAnnotationViewModel(index: i)
            print(annotaion)
            let annotation        = MKPointAnnotation()
            annotation.title      = "\(i)"
            annotation.subtitle   = annotaion.imageUrl
            annotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(annotaion.latu),
                                                           longitude: CLLocationDegrees(annotaion.long))
            self.traficMapView.addAnnotation(annotation)
        }
    }
    
    func openMapForPlace() {
        traficMapView.delegate = self
        let initialLocation    = CLLocation(latitude: 1.3395, longitude: 103.8253)
        traficMapView.centerToLocation(initialLocation)
    }

}


extension MapVC: MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation else {return}
        let annotationToPass = AnnotaionsViewModel(long: annotation.coordinate.longitude, latu: annotation.coordinate.latitude, imageUrl:(annotation.subtitle ?? "no url") ?? "no url" )
        onOnnotationTap?(annotationToPass)
    }
}


