//
//  ErrorViewController.swift
//  WorldRemitTest
//
//  Created by Diego Caroli on 26/02/2020.
//  Copyright © 2020 Diego Caroli. All rights reserved.
//

import UIKit

class ErrorLoadingViewController: UIViewController, Storyboarded {

    @IBOutlet private weak var errorLabel: UILabel!
    @IBOutlet private weak var spinner: UIActivityIndicatorView!
    @IBOutlet private weak var stackLabels: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()

        stackLabels.isHidden = true
        spinner.startAnimating()
    }

    func setupError(_ error: Error) {
        spinner.isHidden = true
        stackLabels.isHidden = false
        errorLabel.text = error.localizedDescription
    }
}
