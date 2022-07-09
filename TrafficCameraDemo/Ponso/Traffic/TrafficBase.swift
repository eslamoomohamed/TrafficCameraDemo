//
//  TrafficBase.swift
//  TrafficCameraDemo
//
//  Created by eslam mohamed on 07/07/2022.
//

import Foundation
struct TrafficBase : Codable {
    let items : [Items]?
    let api_info : ApiInfo?

    enum CodingKeys: String, CodingKey {

        case items = "items"
        case api_info = "api_info"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        items = try values.decodeIfPresent([Items].self, forKey: .items)
        api_info = try values.decodeIfPresent(ApiInfo.self, forKey: .api_info)
    }

}
