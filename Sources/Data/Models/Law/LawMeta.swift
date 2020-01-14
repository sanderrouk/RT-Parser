import Vapor

public struct LawMeta: Content {

    let passed: String
    let published: String
    let inForceFrom: String
    let inForceUntil: String?
    let entryIntoForce: String
    let abbreviation: String
    let textType: String
    let actType: String
    let issuer: String

    public init(
        passed: String,
        published: String,
        inForceFrom: String,
        inForceUntil: String?,
        entryIntoForce: String,
        abbreviation: String,
        textType: String,
        actType: String,
        issuer: String
    ) {
        self.passed = passed
        self.published = published
        self.inForceFrom = inForceFrom
        self.inForceUntil = inForceUntil
        self.entryIntoForce = entryIntoForce
        self.abbreviation = abbreviation
        self.textType = textType
        self.actType = actType
        self.issuer = issuer
    }
}
