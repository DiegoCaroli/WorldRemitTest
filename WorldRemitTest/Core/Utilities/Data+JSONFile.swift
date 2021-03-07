//
//  Data+JSONFile.swift
//  WorldRemitTestTests
//
//  Created by Diego Caroli on 23/02/2020.
//  Copyright © 2020 Diego Caroli. All rights reserved.
//

import Foundation

extension Data {

  public static func fromJSON(fileName: String) throws -> Data {
    let bundle = Bundle(for: AppDelegate.self)
    guard let url = bundle.url(forResource: fileName, withExtension: "json") else {
        preconditionFailure("Unable to find \(fileName).json. Did you add it to the right target?")
    }
    return try Data(contentsOf: url)
  }

}
