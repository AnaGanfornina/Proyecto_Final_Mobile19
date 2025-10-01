@testable import fittrack_server
import VaporTesting
import Testing
import XCTest
import Fluent

@Suite("App Tests with DB", .serialized)
struct fittrackTests {
    private func withApp(_ test: (Application) async throws -> ()) async throws {
        let app = try await Application.make(.testing)
        do {
            try await configure(app)
            try await app.autoMigrate()
            try await test(app)
            try await app.autoRevert()
        } catch {
            try? await app.autoRevert()
            try await app.asyncShutdown()
            throw error
        }
        try await app.asyncShutdown()
    }
    
    @Test("Test Hello World Route")
    func helloWorld() async throws {
        try await withApp { app in
            try await app.testing().test(.GET, "hello", afterResponse: { res async in
                #expect(res.status == .ok)
                #expect(res.body.string == "Hello, world!")
            })
        }
    }
    
    @Test("Rate LimitIP Middleware Test")
    func testRateLimitMiddleware() async throws {
        let app = try await Application.make(.testing)
        do {
            try routes(app)

            for _ in 1...5 {
                try await app.test(.GET, "test-rate") { res in
                    XCTAssertEqual(res.status, .ok)
                }
            }

            // 6th request should fail
            try await app.test(.GET, "test-rate") { res in
                XCTAssertEqual(res.status, .tooManyRequests)
            }

        } catch {
            throw error
        }

        // Cierre asincrónico después del do/catch
        try await app.asyncShutdown()
    }
    
    @Test("Rate Limit User Middleware Test")
    func testRateLimitUserMiddleware() async throws {
        let app = try await Application.make(.testing)
        
        try routes(app)
        
        for i in 1...5 {
            try await app.test(.GET, "test-rate") { res in
                XCTAssertEqual(res.status, .ok)
            }
        }
        
        try await app.test(.GET, "test-rate") { res in
            XCTAssertEqual(res.status, .tooManyRequests)
        }
        
        try await app.asyncShutdown()
    }
}


