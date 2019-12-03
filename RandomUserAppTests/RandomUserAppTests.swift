//
//  RandomUserAppTests.swift
//  RandomUserAppTests
//
//  Created by Alex Paul on 12/2/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import XCTest
@testable import RandomUserApp

class RandomUserAppTests: XCTestCase {
  
  // arrange
  let filename = "randomUsers"
  let ext = "json"
  
  override func setUp() {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testReadingDataFromRandomUsersFile() {
    // act (when)
    let data = Bundle.readRawJSONData(filename: filename, ext: ext)
    
    // assert (then)
    XCTAssertNotNil(data)
  }
  
  func getRawData() -> Data {
    let data = Bundle.readRawJSONData(filename: filename, ext: ext)
    return data
  }
  
  func testParseJSONDataToUserArray() {
    // arrange
    let data = getRawData()
    
    // act
    let users = RandomUserData.getUsers(from: data)
    
    // assert
    XCTAssertGreaterThan(users.count, 0, "\(users.count) should be greater than 0")
  }
  
  func testFirstUserNameIsAlex() {
    // arrange
    let data = getRawData()
    let users = RandomUserData.getUsers(from: data)
    let expectedFirstName = "Alex"
    
    // act
    let firstUser = users.first!
    
    // asset
    XCTAssertEqual(firstUser.name.firstName, expectedFirstName, "\(firstUser.name.firstName) should be equal to \(expectedFirstName)")
  }  
}
