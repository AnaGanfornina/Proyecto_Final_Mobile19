//
//  TrainingDTO.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 19/09/25.
//

import Foundation

struct TrainingDTO: Codable {
    let id: UUID?
    let name: String?
    let scheduledAt: String?
    let traineeId: UUID?
    
    /// A basic constructor that creates a DTO from domain layer, serves to move input data
    init(id: UUID? = nil,
         name: String? = nil,
         scheduledAt: String? = nil,
         traineeId: UUID? = nil) {
        self.id = id
        self.name = name
        self.scheduledAt = scheduledAt
        self.traineeId = traineeId
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name, scheduledAt
        case traineeId = "trainee_id"
    }
    
    /// A constructor that implements the encoding of a Swift type into JSON and is used to create a HTTPBody
    /// - Parameters:
    ///   - decoder: an object of type `(Decoder)` that can decode JSON into Swift types
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.id, forKey: .id)
        try container.encodeIfPresent(self.name, forKey: .name)
        try container.encodeIfPresent(self.scheduledAt, forKey: .scheduledAt)
        try container.encodeIfPresent(self.traineeId, forKey: .traineeId)
    }
    
    /// A constructor that implements the decoding of a JSON into a Swift type and is used to create a DTO
    /// - Parameters:
    ///   - decoder: an object of type `(Decoder)` that can decode JSON into Swift types
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(UUID.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.scheduledAt = try container.decodeIfPresent(String.self, forKey: .scheduledAt)
        self.traineeId = try container.decodeIfPresent(UUID.self, forKey: .traineeId)
    }
}
