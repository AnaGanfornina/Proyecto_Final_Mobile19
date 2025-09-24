//
//  SignupDTO.swift
//  FitTrack_iOS
//
//  Created by Ariana Rodríguez on 22/09/25.
//

import Foundation

enum RoleDTO: Codable {
    case coach, trainee
    
    init(from role: Role) {
        switch role {
        case .coach:
            self = .coach
        case .trainee:
            self = .trainee
        }
    }
}

struct UserDTO: Codable {
    let id: String?
    let email: String
    let password: String
    let role: RoleDTO
    let profile: ProfileDTO
    
    /// A basic constructor that creates a DTO from inside layers
    init(id: String? = nil,
         email: String,
         password: String,
         role: RoleDTO,
         profile: ProfileDTO) {
        self.id = id
        self.email = email
        self.password = password
        self.role = role
        self.profile = profile
    }
    
    enum CodingKeys: String, CodingKey {
        case id, email, password, role, profile
    }
    
    /// A constructor that implements the decoding of a JSON object into a Swift type and is used to create a DTO
    /// - Parameters:
    ///   - decoder: an object of type `(Decoder)` that can decode JSON into Swift types
    init(from decoder: any Decoder) throws {
        var container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(String.self, forKey: .id)
        email = try container.decode(String.self, forKey: .email)
        password = try container.decode(String.self, forKey: .password)
        role = try container.decode(RoleDTO.self, forKey: .role)
        profile = try container.decode(ProfileDTO.self, forKey: .profile)
    }
    
    /// A function that implements the encoding of a Swift type into JSON and is used to create a HTTPBody
    /// - Parameters:
    ///   - encoder: an object of type `(Encoder)` that can encode Swift types into JSON
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encode(email, forKey: .email)
        try container.encode(password, forKey: .password)
        try container.encode(role, forKey: .role)
        try container.encode(profile, forKey: .profile)
    }
}

struct ProfileDTO: Codable {
    let name: String
    let goal: String?
    let coachId: String?
    let age: Int?
    let weight: Double?
    let height: Double?
    
    /// A basic constructor that creates a DTO from inside layers
    init(name: String,
         goal: String? = nil,
         coachId: String? = nil,
         age: Int? = nil,
         weight: Double? = nil,
         height: Double? = nil) {
        self.name = name
        self.goal = goal
        self.coachId = coachId
        self.age = age
        self.weight = weight
        self.height = height
    }
    
    enum CodingKeys: String, CodingKey {
        case name, goal
        case coachId = "coach_id"
        case age, weight, height
    }
    
    /// A constructor that implements the decoding of a JSON object into a Swift type and is used to create a DTO
    /// - Parameters:
    ///   - decoder: an object of type `(Decoder)` that can decode JSON into Swift types
    init(from decoder: any Decoder) throws {
        var container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        goal = try container.decodeIfPresent(String.self, forKey: .goal)
        coachId = try container.decodeIfPresent(String.self, forKey: .coachId)
        age = try container.decodeIfPresent(Int.self, forKey: .age)
        weight = try container.decodeIfPresent(Double.self, forKey: .weight)
        height = try container.decodeIfPresent(Double.self, forKey: .height)
    }
    
    /// A function that implements the encoding of a Swift type into JSON and is used to create a HTTPBody
    /// - Parameters:
    ///   - encoder: an object of type `(Encoder)` that can encode Swift types into JSON
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encodeIfPresent(goal, forKey: .name)
        try container.encodeIfPresent(coachId, forKey: .coachId)
        try container.encodeIfPresent(age, forKey: .age)
        try container.encodeIfPresent(weight, forKey: .weight)
        try container.encodeIfPresent(height, forKey: .height)
    }
}
