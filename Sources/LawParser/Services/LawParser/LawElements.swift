enum LawElements: String {
    case alampunkt
    case alampunktNr
    case sisutekst
    case tavatekst
    case none
}

extension LawElements: RawRepresentable {
    init?(rawValue: String) {
        switch rawValue {
        case "alampunkt":
            self = .alampunkt
        case "alampunktNr":
            self = .alampunktNr
        case "sisutekst", "sisuTekst", "SisuTekst":
            self = .sisutekst
        case "tavatekst", "tavaTekst", "TavaTekst":
            self = .tavatekst
        default:
            return nil
        }
    }
}
