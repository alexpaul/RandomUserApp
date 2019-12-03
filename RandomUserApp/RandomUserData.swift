//
//  RandomUserData.swift
//  RandomUserApp
//
//  Created by Alex Paul on 12/2/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import Foundation

struct RandomUserData: Decodable {
  let results: [User]
}

struct User: Decodable {
  let gender: String
  let name: Name
  let location: Location
}

struct Name: Decodable {
  let title: String
  let firstName: String
  let lastName: String
  
  // snake casing e.g first_name change name to firstName using
  // codingKeys
  private enum CodingKeys: String, CodingKey {
    case title
    case firstName = "first"
    case lastName = "last"
  }
}

struct Location: Decodable {
  let city: String
  let state: String
  let country: String
  //let postcode: Int // broken
  let postcode: Postcode
}

// handle heterogenous data types on "postcode" - could be an Int or String
enum Postcode: Decodable {
  case int(Int)
  case string(String) // associative values
  
  init(from decoder: Decoder) throws {
    if let intValue = try? decoder.singleValueContainer().decode(Int.self) {
      self = .int(intValue)
      return
    }
    if let stringValue = try? decoder.singleValueContainer().decode(String.self) {
      self = .string(stringValue)
      return
    }
    
    // throw an error
    throw AppError.missingValue
  }
  
  func info() -> String {
    switch self {
    case .int(let intValue):
      return intValue.description
    case .string(let stringValue):
      return stringValue
    }
  }
}

enum AppError: Error {
  case missingValue
}



extension RandomUserData {
  static func getUsers(from data: Data) -> [User] {
    var users = [User]()
    do {
      let randomUserData = try JSONDecoder().decode(RandomUserData.self, from: data)
      users = randomUserData.results
    } catch {
      fatalError("decoding error: \(error)")
    }
    return users
  }
}
