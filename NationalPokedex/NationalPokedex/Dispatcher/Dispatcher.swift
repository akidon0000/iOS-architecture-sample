//
//  Dispatcher.swift
//  NationalPokedex
//
//  Created by Akihiro Matsuyama on 2024/04/24.
//

import Foundation

typealias DispatchToken = String

final class Dispatcher {

    static let shared = Dispatcher()

    let lock: NSLocking
    private var callbacks: [DispatchToken: (Action) -> Void]

    init() {
        self.lock = NSRecursiveLock()
        self.callbacks = [:]
    }

    func register(callback: @escaping (Action) -> Void) -> DispatchToken {
        lock.lock(); defer { lock.unlock() }

        let token =  UUID().uuidString
        callbacks[token] = callback
        return token
    }

    func unregister(_ token: DispatchToken) {
        lock.lock(); defer { lock.unlock() }

        callbacks.removeValue(forKey: token)
    }

    func dispatch(_ action: Action) {
        lock.lock(); defer { lock.unlock() }

        callbacks.forEach { _, callback in
            callback(action)
        }
    }
}
