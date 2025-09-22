import NIOSSL
import Fluent
import FluentSQLiteDriver
import Vapor
import JWT

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    // TODO: Undo changes
    let jwtKey = "jwt"
    //guard let _ = Environment.process.API_KEY else { fatalError("API_KEY required")}
    
    app.databases.use(DatabaseConfigurationFactory.sqlite(.file("dbfittrack.sqlite")), as: .sqlite)

    // Set password algorithm
    app.passwords.use(.bcrypt)
    
    // Configure JWT
    let hmacKey = HMACKey(stringLiteral: jwtKey)
    await app.jwt.keys.add(hmac: hmacKey, digestAlgorithm: .sha512)

    // Add migrations
    app.migrations.add(CreateUser())
    app.migrations.add(CreateTraining())
    try await app.autoMigrate()

    // register routes
    try routes(app)
}
