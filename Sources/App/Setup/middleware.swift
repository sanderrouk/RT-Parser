import Vapor

public func middleware(config: inout MiddlewareConfig)  {
    config.use(ErrorMiddleware.self)
    setupCors(config: &config)
    config.use(SessionsMiddleware.self) // Enables sessions.
    // config.use(FileMiddleware.self) // Serves files from `Public/` directory
    config.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
}

private func setupCors(config: inout MiddlewareConfig) {
    let corsConfiguration = CORSMiddleware.Configuration(
        allowedOrigin: .all,
        allowedMethods: [
            .GET,
            .POST,
            .PUT,
            .OPTIONS,
            .DELETE,
            .PATCH
        ],
        allowedHeaders: [
            .accept,
            .authorization,
            .contentType,
            .origin,
            .xRequestedWith,
            .userAgent,
            .accessControlAllowOrigin
        ]
    )
    let corsMiddleware = CORSMiddleware(configuration: corsConfiguration)
    config.use(corsMiddleware)
}
