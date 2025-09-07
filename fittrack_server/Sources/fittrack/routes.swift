import Fluent
import Vapor

func routes(_ app: Application) throws {
   
    try app.register(collection: UserController())
//    try app.register(collection: TrainingController())
//    try app.register(collection: ExerciseController())
//    try app.register(collection: AppointmentController())
}
