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
//      print(str)
//      let decoder = JSONDecoder()
//      guard let decodedFromAPI = try? decoder.decode(APIJSONResponse.self, from: data) else {
//        print("Got the data from the API but can't decode the JSON :[")
//        return
//      }
//      print(decodedFromAPI)
      completion(reportedWeight)
    }.resume()
  }

}
