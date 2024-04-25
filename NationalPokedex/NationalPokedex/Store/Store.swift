//
//  Store.swift
//  NationalPokedex
//
//  Created by Akihiro Matsuyama on 2024/04/24.
//

import Foundation

class Store: ObservableObject {
    private lazy var dispatchToken: DispatchToken = {
        return dispatcher.register(callback: { [weak self] action in
            self?.onDispatch(action)
        })
    }()

    private let dispatcher: Dispatcher

    deinit {
        dispatcher.unregister(dispatchToken)
    }

    init(dispatcher: Dispatcher) {
        self.dispatcher = dispatcher
        _ = dispatchToken
    }

    func onDispatch(_ action: Action) {
        fatalError("must override")
    }
}
