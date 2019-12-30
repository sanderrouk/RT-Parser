import Vapor

public struct LawMeta: Content {
    let passed: String
    let published: String
    let inForceFrom: String
    let inForceUntil: String
    let entryIntoForce: String
    let abbreviation: String
    let textType: String
    let actType: String
    let issuer: String
}
