import Fluent
import Vapor

func routes(_ app: Application) throws {
   
    app.get { req async in
        "It works!"
    }
    
    try app.group("api") { builder in
        try builder.register(collection: AuthController())
        try app.register(collection: UserController())
        //    try app.register(collection: TrainingController())
        //    try app.register(collection: ExerciseController())
        //    try app.register(collection: AppointmentController())
    }
}
