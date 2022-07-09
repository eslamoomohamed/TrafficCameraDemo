//
//  MockNetworkManagerTests.swift
//  TrafficCameraDemoTests
//
//  Created by eslam mohamed on 07/07/2022.
//

import XCTest
@testable import TrafficCameraDemo

class MockNetworkManagerTests: XCTestCase {
    
    var sut:INetworkManager!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = NetworkMock(responseError: false)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }

    func testMockApiFunc() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        sut.fetchDataFromApi(urlString: "", baseModel: TrafficBase.self) { result in
            switch result{
            case .success(let response):
                XCTAssertNotNil(response)
            case .failure(let error):
                print(error)
                XCTFail()
            }

        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
