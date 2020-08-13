//
//  NetworkingHandler.swift
//  LiftingLog
//
//  Created by TSS on 2020/8/13.
//  Copyright © 2020 TSS. All rights reserved.
//

import Foundation

struct APIJSONResponse: Decodable {
  var weight: String
}

class Networking {
  
  static let sharedInstance = Networking()
  
  func readTotalWeightFromAPI(completion: @escaping (Float) -> ()) {
    guard let url = URL(string: "https://liftinglog-backend.herokuapp.com/getWeight") else {
      fatalError()
    }
    URLSession.shared.dataTask(with: url) {data, response, taskError in
      guard let httpResponse = response as? HTTPURLResponse,
        (200..<300).contains(httpResponse.statusCode),
        let data = data else {
          print("Received an error from httpResponse")
          return
      }
      guard let reportedWeight = Float(String(decoding: data, as: UTF8.self)) else {
        return
      }
      completion(reportedWeight)
    }.resume()
  }
  
  func postWeightChangeToAPI(withWeight change: Float, completion: @escaping (Bool) -> ()) {
    guard let url = URL(string: "https://liftinglog-backend.herokuapp.com/addWeight") else {
      fatalError()
    }
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    let postString = "weight=\(change)"
    request.httpBody = postString.data(using: String.Encoding.utf8);
    URLSession.shared.dataTask(with: request) { (data, response, error) in
      // Check for Error
      if let error = error {
        print("Error took place \(error)")
        return
      }
      // Convert HTTP Response Data to a String
      if let data = data, let dataString = String(data: data, encoding: .utf8) {
        print("Response data string:\n \(dataString)")
      }
      completion(true)
    }.resume()
  }
}

func updateTotalWeightOnServer(with difference: Float) {
  Networking.sharedInstance.postWeightChangeToAPI(withWeight: difference) { (success) in
     DispatchQueue.main.async {
      print("updated the total weight on the server")
     }
   }
}

