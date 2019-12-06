//
//  NetworkLayerMock.swift
//  NYTBookAppTests
//
//  Created by wirawan on 5/12/19.
//  Copyright © 2019 wirawan. All rights reserved.
//

import Foundation
import NYTBookApp

class NetworkLayerMock: Network {

    private let mockedData: [String:Any]

    init(mockedData:[String:Any]) {
        self.mockedData = mockedData
    }

    override func executeGETRequest(api:String, completionBlock:@escaping (Data?) -> Void)  {
        let data = toJSONString(mockedData: self.mockedData)
        completionBlock(data)
    }

    func toJSONString(mockedData:[String:Any]?) -> Data? {
        if let arr = mockedData {
            let dat = try? JSONSerialization.data(withJSONObject: arr, options: .prettyPrinted)
            return dat
        }
        return nil
    }
}

