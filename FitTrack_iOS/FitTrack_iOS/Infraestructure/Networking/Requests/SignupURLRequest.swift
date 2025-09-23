//
//  SignupURLRequest.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 22/09/25.
//

import Foundation

struct SignupURLRequest: URLRequestComponents {
    typealias Response = AuthDTO
    var path: String = "/api/auth/register"
    var httpMethod: HTTPMethod = .POST
    var authorized: Bool = false
    var body: (any Encodable)?
    
    init(userDTO: UserDTO) {
        body = userDTO
    }
}
