//
//  PokeIndexPresenter.swift
//  NationalPokedex
//
//  Created by Akihiro Matsuyama on 2024/04/18.
//

import UIKit
import SwiftUI

enum PokeIndexDestination {
    case detail(Pokemon)
}

protocol PokeIndexPresenterProtocol: AnyObject {
    var isNavigating: Bool { get set }
    func navigate(_ destination: PokeIndexDestination) -> PokeDetailView
    func loadStart()
    func requestMorePokemons(pokemons: [Pokemon])
}

class PokeIndexPresenter: UIViewController {
    // ナビゲーションから戻ってきたかどうかを監視する
    var isNavigating = false

    private var hostingController: UIHostingController<PokeIndexView>!
    private var pokeIndexView: PokeIndexView!
    private var pokeDetailView: PokeDetailView!
    private var model: PokeApiModelProtocol!

    public func inject(view: PokeIndexView, model: PokeApiModelProtocol) {
        self.pokeIndexView = view
        self.model = model
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        guard model != nil, pokeIndexView != nil else {
            print("PresenterにModelとViewを指定してください")
            return
        }

        hostingController = UIHostingController(rootView: pokeIndexView)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(hostingController.view)

        NSLayoutConstraint.activate([
            hostingController.view.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height),
            hostingController.view.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            hostingController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        ])
    }
}

extension PokeIndexPresenter: PokeIndexPresenterProtocol {
    func navigate(_ destination: PokeIndexDestination) -> PokeDetailView {
        switch destination {
        case .detail(let pokemon):
            return PokeDetailView(type: .display(pokemon))
        }
    }

    func loadStart() {
        requestMorePokemons(pokemons: [])
    }

    func requestMorePokemons(pokemons: [Pokemon]) {
        Task {
            let result = await self.model.getNewPokemons(pokemons: pokemons)
            await MainActor.run {
                switch result {
                case .success(let updatedPokemons):
                    self.pokeIndexView = PokeIndexView(delegate: self, type: .display(updatedPokemons))
                case .failure(let error):
                    self.pokeIndexView = PokeIndexView(delegate: self, type: .error(error))
                }
            }
            self.hostingController.rootView = self.pokeIndexView
        }
    }
}
