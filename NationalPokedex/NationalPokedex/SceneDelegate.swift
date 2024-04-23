//
//  SceneDelegate.swift
//  NationalPokedex
//
//  Created by Akihiro Matsuyama on 2024/04/20.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let pokeIndexPresenter = PokeIndexPresenter()
        let view = PokeIndexView(delegate: pokeIndexPresenter, type: .display([Pokemon]()))
        let model = PokeApiModel()
        pokeIndexPresenter.inject(view: view, model: model)

        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = pokeIndexPresenter
        window?.makeKeyAndVisible()
    }
}
