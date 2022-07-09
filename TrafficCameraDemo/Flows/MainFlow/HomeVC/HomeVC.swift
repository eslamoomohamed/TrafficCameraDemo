//
//  HomeVC.swift
//  TrafficCameraDemo
//
//  Created by eslam mohamed on 07/07/2022.
//

import UIKit

class HomeVC: UIViewController,StoryboardLoad {
    
    weak var coordinator: HomeVCCoordinator?
    var pushVC: ((String) -> Void)?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private func configureView(){
        view.backgroundColor = .white
    }

    @IBAction func showMapButtonTap(_ sender: Any) {
        print("Show map button")
        pushVC?("MapVC")
    }
}
