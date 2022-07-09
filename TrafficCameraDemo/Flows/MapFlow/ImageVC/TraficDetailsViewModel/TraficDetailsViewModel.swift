//
//  TraficDetailsViewModel.swift
//  TrafficCameraDemo
//
//  Created by eslam mohamed on 07/07/2022.
//

import UIKit

protocol ItraficDetailsViewModel{
    func fetchImage()
}

class traficDetailsViewModel: ItraficDetailsViewModel {
    
    var image: UIImage = UIImage(){
        didSet{
            self.updateImageClosure()
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
    var imageUrl: String?
    var updateImageClosure:()->()    = {}
    var showLoadingToView: (()->())  = {}
    var hideLoadingToView: (()->())  = {}
    
    
    init(imageUrl: String,networkShared:INetworkManager? = NetworkManager.shared) {
        self.imageUrl = imageUrl
        self.networkShared = networkShared
    }
    
    
    
    func fetchImage() {
        self.state = .loading
        networkShared?.downloadImg(from: imageUrl ?? "no url") { result in
            self.state = .finished
            switch result{
            case .success(let data):
                self.image = UIImage(data: data)!
            case .failure(let error):
                print(error)
            }
        }
        
    }
}
