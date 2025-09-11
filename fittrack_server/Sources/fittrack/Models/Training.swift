//
//  File.swift
//  fittrack_server
//
//  Created by Álvaro Entrena Casas on 6/9/25.
//

import Foundation
import Vapor
import Fluent

final class Training: Model, Content, @unchecked Sendable {
    static let schema = "training"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "name")
    var name: String
    
    @Field(key: "start")
    var start: Date
    
    @Field(key: "end")
    var end: Date
    
    @Field(key: "userID")
    var userID: UUID
    
    init() {}
    
    init(name: String, start: Date, end: Date , userID: UUID) {
        self.name = name
        self.start = start
        self.end = end
        self.userID = userID
    }
}
