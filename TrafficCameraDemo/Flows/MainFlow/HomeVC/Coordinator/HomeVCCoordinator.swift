//
//  HomeVCCoordinator.swift
//  TrafficCameraDemo
//
//  Created by eslam mohamed on 07/07/2022.
//

import UIKit

class HomeVCCoordinator:BaseCoordinator {
    
    weak var parentCoordinator: MainCoordinator?
    
    override init(navigationController: UINavigationController){
        super.init(navigationController: navigationController)
    }
    
    override func start() {
        let vc = HomeVC.instaniateStoryboard()
        vc.coordinator = self
        vc.pushVC = {  [weak self] VCName in
            switch VCName{
            case "MapVC":
                self?.pushMapVC()
            default:
                print("invalid name")
            }
        }
        navigationController.pushViewController(vc, animated: false)
    }
    
    func toPresent() -> UIViewController{
        return navigationController
    }
    
    func pushMapVC(){
        let vc = MapVC.instaniateStoryboard()
        vc.coordinator = self
        vc.onOnnotationTap = { [weak self] annotationDetails in
            guard let self = self else {return}
            print(annotationDetails.long)
            let trficViewModel = traficDetailsViewModel(imageUrl: annotationDetails.imageUrl)
            let traficDetails = traficDetails.instaniateStoryboard()
            traficDetails.viewModel = trficViewModel
            self.navigationController.present(traficDetails, animated: true, completion: nil)
//            self.navigationController.pushViewController(traficDetails, animated: true)
        }
        navigationController.pushViewController(vc, animated: true)
    }
    
}
