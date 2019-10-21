import Authentication

import Vapor
import VaporExt

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {

    /// This helps you configure env variables for development in a .env file in the main dir, see .env.example
    if !env.isRelease {
        Environment.dotenv()
    }

    /// Register Providers
    try setupProviders(config: &config, services: &services)

    /// Register routes to the router
    services.register(Router.self) { container -> EngineRouter in
        let router = EngineRouter.default()
        try routes(router, container)
        return router
    }

    /// Register middleware
    var middlewareConfig = MiddlewareConfig()
    middleware(config: &middlewareConfig)
    services.register(middlewareConfig)

    /// Set up commands
    var commandConfig = CommandConfig.default()
    commandConfig.useFluentCommands()
    services.register(commandConfig)

    /// Set up datasources
    var databasesConfig = DatabasesConfig()
    try databases(config: &databasesConfig, env: env)
    services.register(databasesConfig)

    /// Set up migrations
    services.register { container -> MigrationConfig in
        var migrationConfig = MigrationConfig()
        try migrate(migrations: &migrationConfig)
        return migrationConfig
    }

    /// Set up external models
    models()

    /// Generate documentation
    document()

    /// Set up repositories
    setupRepositories(services: &services)

    /// Set up services
    try setupServices(services: &services, env: env)

}
