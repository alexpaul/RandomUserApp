//
//  Bundle+Extensions.swift
//  RandomUserApp
//
//  Created by Alex Paul on 12/2/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import Foundation

extension Bundle { // Bundle.parseJSONData(.....)
  static func readRawJSONData(filename: String, ext: String) -> Data {
    guard let fileURL = Bundle.main.url(forResource: filename, withExtension: ext) else {
      fatalError("resource with filename \(filename) not found")
    }
    var data: Data!
    do {
      data = try Data.init(contentsOf: fileURL)

    } catch {
      fatalError("contents not found error: \(error)")
    }
    return data
  }
}
