//
//  CreateTrainingURLRequest.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 19/09/25.
//

import Foundation

struct CreateTrainingURLRequest: URLRequestComponents {
    typealias Response = TrainingDTO
    var path: String = "/api/trainings"
    var httpMethod: HTTPMethod = .POST
    var authorized: Bool = true
    var body: (any Encodable)?
    
    init(name: String, traineeId: UUID) {
        body = Body(
            name: name,
            traineeId: traineeId.uuidString
        )
    }
}

extension CreateTrainingURLRequest {
    struct Body: Encodable {
        let name: String
        let traineeId: String
        // TODO: Send exercises data
    }
}
