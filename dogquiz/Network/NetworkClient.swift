//
//  NetworkClient.swift
//  dogquiz
//
//  Created by Winson Heng on 9/3/25.
//
import OpenAPIURLSession
import SwiftUI

class NetworkClient {
    private var _client: Client
    var client: Client {
        return _client
    }

    private init() throws {
        _client = Client(
            serverURL: try Servers.Server1.url(),
            transport: URLSessionTransport()
        )
    }
    

    static let shared: NetworkClient = {
        do {
            return try NetworkClient()
        } catch {
            fatalError("Failed to initialize NetworkClient: \(error)")
        }
    }()
}
