//
//  ViewController.swift
//  NationalPokedex
//
//  Created by Akihiro Matsuyama on 2024/04/18.
//

import UIKit
import SwiftUI

protocol ViewProtocol: AnyObject {
    func loadStart()
    func requestMorePokemons()
}

final class ViewController: UIViewController {
    private let model = PokeApiModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        let newViewController = UIHostingController(rootView: PokeIndexView(delegate: self))

        newViewController.view.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(newViewController.view)

        NSLayoutConstraint.activate([
            newViewController.view.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height),
            newViewController.view.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            newViewController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        ])
    }
}

extension ViewController: ViewProtocol {
    func loadStart() {
        model.requestMorePokemons()
    }

    func requestMorePokemons() {
        model.requestMorePokemons()
    }
}
