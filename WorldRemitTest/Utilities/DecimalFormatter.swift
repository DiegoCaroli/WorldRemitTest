//
//  DecimalFormatter.swift
//  WorldRemitTest
//
//  Created by Diego Caroli on 26/02/2020.
//  Copyright © 2020 Diego Caroli. All rights reserved.
//

import Foundation

class DecimalFormatter {

    private let locale: Locale

    private lazy var numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = locale
        return formatter
    }()

    init(locale: Locale = .current) {
        self.locale = locale
    }

    func string(from decimal: Decimal) -> String {
        return numberFormatter.string(from: decimal as NSNumber)!
    }
}
