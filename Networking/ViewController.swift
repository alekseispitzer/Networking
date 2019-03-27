//
//  ViewController.swift
//  Networking
//
//  Created by Alek Spitzer on 3/27/19.
//  Copyright © 2019 alekspitzer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	let urlString = "https://httpbin.org/anything"
	let configuration = URLSessionConfiguration.default
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
//		makeAPIRequestGET()
//		makeAPIRequestPOST()
		
	}


	func makeAPIRequestGET() {
		
		// Create URL session object. Usually we use the shared singleton for memory performance reasons, this is just an example.
		let urlSession = URLSession(configuration: configuration)
		// Specify URL
		let url = URL(string: urlString)!
		// Creates a task that retrieves the contents of the specified URL, then calls a handler upon completion.
		let urlSessionDataTask = urlSession.dataTask(with: url) { (data, response, error) in
			
			guard let data = data else {
				print("no data was returned")
				return
			}
			guard let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String:Any] else {
				print("error during json serialization")
				return
			}
			
			print("json response dictionary is \n \(String(describing: json))")
			// work with the json object here
		}
		
		urlSessionDataTask.resume()
	}
	
	func makeAPIRequestPOST() {
		
		// Create URL session object. Usually we use the shared singleton for memory performance reasons, this is just an example.
		let urlSession = URLSession(configuration: configuration)
		// URL
		let url = URL(string: urlString)!
		// URL Request
		let dictToSend: [String:Any] = ["name":"Alek","profession":"developer"]
		
		var urlRequest = URLRequest(url: url)
		urlRequest.httpMethod = "POST"
		urlRequest.httpBody = getPostDataFromDict(dictToSend)
		
		
		let urlSessionDataTask = urlSession.dataTask(with: urlRequest) { (data, response, error) in
			guard let data = data else {
				return
			}
			guard let json = (try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any] else {
				print("Not containing JSON")
				return
			}
			
			print("json response dictionary is \n \(String(describing: json))")
		}
		
		urlSessionDataTask.resume()
	}
	
	
	// MARK: - Helper Methods
	func getPostDataFromDict(_ postDataDict: [String:Any]) -> Data? {
		if let data = try? JSONSerialization.data(withJSONObject: postDataDict, options: []) {
			return data
		}
		return nil
	}
	
}

