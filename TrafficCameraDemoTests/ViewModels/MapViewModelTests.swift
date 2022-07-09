//
//  MapViewModelTests.swift
//  TrafficCameraDemoTests
//
//  Created by eslam mohamed on 07/07/2022.
//

import XCTest
@testable import TrafficCameraDemo

class MapViewModelTests: XCTestCase {
    
    
    var viewModel:IMapViewModel!
    var annotationViewModel: AnnotaionsViewModel!
    var mockDataForCreateAnnotationViewModel:NetworkMock!
    

    override func setUpWithError() throws {
        viewModel = MapViewModel()
        annotationViewModel = AnnotaionsViewModel(long: 103.871146, latu: 1.29531332, imageUrl: "https://images.data.gov.sg/api/traffic-images/2022/07/a48f53ad-2e44-4bdd-a69f-985faed293b7.jpg")
        mockDataForCreateAnnotationViewModel = NetworkMock(responseError: false)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        annotationViewModel = nil
        mockDataForCreateAnnotationViewModel = nil
    }
    
    
    func testCreateAnnotationViewModel() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        mockDataForCreateAnnotationViewModel.fetchDataFromApi(urlString: "", baseModel: TrafficBase.self) { result in
            switch result{
            case .success(let trafficBase):
                guard let cameras = trafficBase.items?[0].cameras else{return}
                //cameras[1]
                let annotationVM = self.viewModel.createAnnotationsViewModel(item: cameras[0])
                XCTAssert(annotationVM == self.annotationViewModel)
            case .failure(let error):
                print(error)
                XCTFail()
            }
        }
    }
    
    func testprocessFetchedTrafficFunc() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        mockDataForCreateAnnotationViewModel.fetchDataFromApi(urlString: "", baseModel: TrafficBase.self) { result in
            switch result{
            case .success(let trafficBase):
                guard let cameras = trafficBase.items?[0].cameras else{return}
                self.viewModel.processFetchedTraffic(items: cameras)
                //Index(0)
                XCTAssertTrue(self.viewModel.getAnnotationViewModel(index: 0) == self.annotationViewModel)
            case .failure(let error):
                print(error)
                XCTFail()
            }
        }
    }

}
