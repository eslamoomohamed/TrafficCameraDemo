//
//  MapViewModel.swift
//  TrafficCameraDemo
//
//  Created by eslam mohamed on 07/07/2022.
//

import Foundation

protocol IMapViewModel{
    func fetchData()
    func getAnnotationViewModel(index: Int) -> AnnotaionsViewModel
    func createAnnotationsViewModel(item: Cameras) -> AnnotaionsViewModel
    func processFetchedTraffic(items:[Cameras])
}

class MapViewModel: IMapViewModel{
    
    
    var annotationsViewModel:[AnnotaionsViewModel] = [AnnotaionsViewModel](){
        didSet{
            self.updateMapViewClosure()
        }
    }
    
    var numberOfAnnotaion:Int{
        return annotationsViewModel.count
    }
    
    
    private var errorMessage:ErrorMessages!{
        didSet{
            self.showErrorMessageClosure()
        }
    }
    
    var state:State = .empty{
        didSet{
            switch state{
            case .loading:
                self.showLoadingToView()
            case .finished:
                self.hideLoadingToView()

            default:
                self.showLoadingToView()
            }
        }
    }
    var networkShared:INetworkManager?
    var updateMapViewClosure:()->()       = {}
    var showAlertMessageClosure: (()->()) = {}
    var showErrorMessageClosure: (()->()) = {}
    var showLoadingToView:  (()->())      = {}
    var hideLoadingToView: (()->())       = {}
    
    
    init(networkShared:INetworkManager? = NetworkManager.shared) {
        self.networkShared = networkShared
    }
    
    
    func fetchData() {
        self.state = .loading
        networkShared?.fetchDataFromApi(urlString: URLs.traffic(), baseModel: TrafficBase.self) { result in
            self.state = .finished
            switch result{
            case .success(let data):
                guard let cameras = data.items?[0].cameras else{return}
                self.processFetchedTraffic(items: cameras)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getAnnotationViewModel(index: Int)-> AnnotaionsViewModel{
        return annotationsViewModel[index]
    }
    
    func createAnnotationsViewModel(item: Cameras) -> AnnotaionsViewModel{
        let annotationViewModel = AnnotaionsViewModel(long: item.location?.longitude ?? 0, latu: item.location?.latitude ?? 0,imageUrl: item.image ?? "no url")
        return annotationViewModel
    }
    
    func processFetchedTraffic(items:[Cameras]){
        var annotationViewModel = [AnnotaionsViewModel]()
        for item in items {
            annotationViewModel.append(createAnnotationsViewModel(item: item))
        }
        self.annotationsViewModel.append(contentsOf: annotationViewModel)
    }
    
    
}
