//
//  XCTestCase+loadFromStub.swift
//  TrafficCameraDemoTests
//
//  Created by eslam mohamed on 07/07/2022.
//

import XCTest

extension XCTest {
    func loadStubFromBundle(withName name: String, extension: String) -> Data {
        let bundle = Bundle(for: classForCoder)
        let url = bundle.url(forResource: name, withExtension: `extension`)

        return try! Data(contentsOf: url!)
    }
}
