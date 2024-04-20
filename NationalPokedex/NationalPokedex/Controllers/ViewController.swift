//
//  ViewController.swift
//  NationalPokedex
//
//  Created by Akihiro Matsuyama on 2024/04/18.
//

import UIKit
import SwiftUI

protocol ViewProtocol: AnyObject {
}

class ViewController: UIViewController {
    private let model = PokeApiModel()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ViewController: ViewProtocol {
}
