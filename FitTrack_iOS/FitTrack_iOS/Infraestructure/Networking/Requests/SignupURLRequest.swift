//
//  SignupURLRequest.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 22/09/25.
//

import Foundation

struct SignupURLRequest: URLRequestComponents {
    typealias Response = AuthDTO
    var path: String
    var httpMethod: HTTPMethod = .POST
    var authorized: Bool = false
    var body: (any Encodable)?
    
    init(userDTO: UserDTO) {
        path = userDTO.role == .coach
        ? "/api/auth/register/coach"
        : "/api/auth/register/trainee"
        authorized = userDTO.role == .trainee
        body = userDTO
    }
}
