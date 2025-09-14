import Fluent
import Vapor

func routes(_ app: Application) throws {
   
    app.get { req async in
        "It works!"
    }
    
    try app.group("api") { builder in
        try builder.register(collection: AuthController())
        try builder.register(collection: UserController())
    }
}
