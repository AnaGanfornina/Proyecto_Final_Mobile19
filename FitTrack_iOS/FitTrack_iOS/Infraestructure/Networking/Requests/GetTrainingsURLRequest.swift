//
//  GetTrainingsURLRequest.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 18/09/25.
//

import Foundation

struct GetTrainingsURLRequest: URLRequestComponents {
    typealias Response = [TrainingDTO]
    var path: String = "/api/trainings"
    var httpMethod: HTTPMethod = .GET
    var authorized: Bool = true
    var queryParameters: [String : String]?
    
    init(filter: String?) {
        if let filter {
            queryParameters = ["filter": filter]
        }
    }
}
