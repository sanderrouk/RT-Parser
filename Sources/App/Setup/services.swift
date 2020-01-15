import Vapor
import LawHierarchy
import LawParser
import TimerJobs
import Data

public func setupServices(services: inout Services, env: Environment) throws {
    services.register(LawServiceImpl.self)
    services.register(LawUrlAndAbbreviationProviderImpl.self)
    services.register(TimerJobServiceImpl.self)
    services.register(LawParsingServiceImpl.self)
    services.register(NetworkingServiceImplementation.self)
}
