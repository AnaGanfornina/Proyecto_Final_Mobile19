//
//  GetTraineesURLRequest.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 23/09/25.
//

struct GetTraineesURLRequest: URLRequestComponents {
    typealias Response = [UserDTO]
    var path: String = "/api/users"
    var httpMethod: HTTPMethod = .GET
    var authorized: Bool = true
}
