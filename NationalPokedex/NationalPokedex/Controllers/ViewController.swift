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
        let newViewController = UIHostingController(rootView: PokeIndexView(viewModel: PokeIndexViewModel()))

        newViewController.view.translatesAutoresizingMaskIntoConstraints = false
        newViewController.view.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height).isActive = true
        newViewController.view.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true

        view.addSubview(newViewController.view)
    }
}

extension ViewController: ViewProtocol {
}
