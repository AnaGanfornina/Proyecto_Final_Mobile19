//
//  File.swift
//  fittrack_server
//
//  Created by Álvaro Entrena Casas on 6/9/25.
//

import Foundation
import Fluent
import Vapor

final class Exercise: Model, Content, @unchecked Sendable {
    static let schema: String = "exercise"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "name")
    var name: String
    
    @Field(key: "description")
    var description: String
    
    @Field(key: "repetitions")
    var repetitions: Int
    
    @Field(key: "sets")
    var sets: Int
    
    @Field(key: "trainingID")
    var trainingID: UUID
    
    init() {}
    
    init(name:String, description: String, repetitions: Int, sets: Int, trainingID: UUID) {
        
    }
}
