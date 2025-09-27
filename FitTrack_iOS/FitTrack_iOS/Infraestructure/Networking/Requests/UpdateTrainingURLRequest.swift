//
//  UpdateTrainingURLRequest.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 26/09/25.
//

import Foundation

struct UpdateTrainingURLRequest: URLRequestComponents {
    typealias Response = TrainingDTO
    var path: String = "/api/training"
    var httpMethod: HTTPMethod = .PATCH
    var authorized: Bool = true
    var body: (any Encodable)?
    
    init(trainingDTO: TrainingDTO) {
        body = trainingDTO
    }
}
