//
//  Network.swift
//  NYTBookApp
//
//  Created by wirawan on 5/12/19.
//  Copyright © 2019 wirawan. All rights reserved.
//

import UIKit
import Foundation
import NVActivityIndicatorView

open class Network: NSObject {
    open func executeGETRequest(api:String, completionBlock:@escaping (Data?) -> Void)  {
        let activityIndicatorSize = CGSize(width: 35, height: 35)
        let activityIndicatorData = ActivityData.init(size: activityIndicatorSize, message: nil, messageFont: nil, type: .ballGridPulse, color: UIColor.black, padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: UIColor.clear, textColor: nil)
        let environment = ProcessInfo.processInfo.environment
        var baseUrl:String = ""

        if let _ = environment["isUITest"] {
            // Running in a UI test
            baseUrl = ProcessInfo.processInfo.environment["BASEURL"]!
        } else {
            baseUrl = "https://api.nytimes.com/svc/books/v3"
        }

        guard let url = URL(string: baseUrl + api) else { return }
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityIndicatorData)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
            guard let data = data else {

                if let err = error {
                    print("Err", err)
                    self.showAlertWithMessage(message: err.localizedDescription)
                }
                return
            }

            do {
                if let returnData = String(data: data, encoding: .utf8) {
                    print(returnData)
                } else {
                    print("empty")
                }
            }

            completionBlock(data)
        }
        dataTask.resume()
    }
}

extension Network {
    private func showAlertWithMessage(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler:nil))
        DispatchQueue.main.async {
            let appDelegate = UIApplication.shared.windows.first { $0.isKeyWindow }
            var presentVC = appDelegate?.rootViewController
            while let next = presentVC?.presentedViewController {
                presentVC = next
            }
            presentVC?.present(alert, animated: true, completion: nil)
        }
    }
}
