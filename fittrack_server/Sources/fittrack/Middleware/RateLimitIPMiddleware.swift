
import Vapor

final class RateLimitIPMiddleware: AsyncMiddleware, @unchecked Sendable {
    private var requestLog: [String: [Date]] = [:]
    private var maxRequest: Int
    private var window: TimeInterval // seconds
    
    init(maxRequest: Int = 10, window: TimeInterval = 60) {
        self.maxRequest = maxRequest
        self.window = window
    }
    
    func respond(to request: Request, chainingTo next: any AsyncResponder) async throws -> Response {
        // Detect IP through forward header or remoteAddress
        let forwardedIP = request.headers.forwarded.first?.for
        let identifier = forwardedIP ?? request.remoteAddress?.description ?? "unknown"
        let now = Date()
        let response = Response(status: .tooManyRequests)
        response.headers.replaceOrAdd(name: "Retry-after", value: "\(Int(window))")
        
        // filter requests out of window
        let cutOff = now.addingTimeInterval(-window)
        let validRequest = (self.requestLog[identifier] ?? []).filter { $0 > cutOff }
        
        guard validRequest.count < maxRequest else {
            throw Abort(.tooManyRequests, reason: "Too many requests from this IP")
        }
        
        self.requestLog[identifier] = validRequest + [now]
        
        return try await next.respond(to: request)
    }
    
    
}
