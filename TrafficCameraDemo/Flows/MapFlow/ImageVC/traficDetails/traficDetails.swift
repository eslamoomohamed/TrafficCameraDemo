//
//  traficDetails.swift
//  TrafficCameraDemo
//
//  Created by eslam mohamed on 07/07/2022.
//

import UIKit

class traficDetails: UIViewController,StoryboardLoad {
    
    var viewModel: traficDetailsViewModel?
    @IBOutlet weak var headerImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        updateViewWithLoadingView()
    }
    
    private func bindViewModel(){
        updateViewWithLoadingView()
        updateViewWithData()
        viewModel?.fetchImage()
    }
    
    private func updateViewWithLoadingView(){
        viewModel?.showLoadingToView = { DispatchQueue.main.async { self.showLoadingView() } }
        viewModel?.hideLoadingToView = { DispatchQueue.main.async { self.removeLoadingView() } }
    }
    
    private func updateViewWithData(){
        viewModel?.updateImageClosure = {
            DispatchQueue.main.async { self.headerImage.image = self.viewModel?.image }
        }
    }
}
