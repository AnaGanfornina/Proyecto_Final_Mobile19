//
//  CreateTrainingURLRequest.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 19/09/25.
//

import Foundation

struct CreateTrainingURLRequest: URLRequestComponents {
    typealias Response = TrainingDTO
    var path: String = "/api/training"
    var httpMethod: HTTPMethod = .POST
    var authorized: Bool = true
    var body: (any Encodable)?
    
    init(name: String, traineeId: UUID, scheduledAt: String) {
        body = Body(
            name: name,
            traineeId: traineeId,
            scheduledAt: scheduledAt
        )
    }
}

extension CreateTrainingURLRequest {
    struct Body: Encodable {
        let name: String
        let traineeId: UUID
        let scheduledAt: String
        // TODO: Sent exercises data
        
        enum CodingKeys: String, CodingKey {
            case name
            case traineeId = "trainee_id"
            case scheduledAt
        }
    }
}
