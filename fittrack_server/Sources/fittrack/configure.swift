import NIOSSL
import Fluent
import FluentSQLiteDriver
import Vapor
import JWT

// configures your application
public func configure(_ app: Application) async throws {
  
    // JWT Key from environment
    guard let jwtKey = Environment.get("JWT_KEY") else {
        app.logger.warning("JWT_SECRET not found ")
        fatalError("JWT_SECRET required - create a file env.development")
    }
    
    // Configurate environments
    switch app.environment {
    case .development:
        app.databases.use(.sqlite(.file("db.sqlite")), as: .sqlite)
        app.logger.info("Using sqlite for development")
    case .production:
        app.databases.use(.sqlite(.file("prod_database.sqlite")), as: .sqlite)
        app.logger.info("Production configuration")
    default:
        fatalError("Unsupported environment: \(app.environment)")
    }
    
    app.logger.info("Current Environment: \(app.environment)")
    
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
