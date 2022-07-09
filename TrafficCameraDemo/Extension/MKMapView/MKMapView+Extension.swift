//
//  MKMapView+Extension.swift
//  TrafficCameraDemo
//
//  Created by eslam mohamed on 07/07/2022.
//

import MapKit

extension MKMapView {
  func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 40000) {
    let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
}
