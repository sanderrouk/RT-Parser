enum LawElements: String {
    case alampunkt
    case alampunktNr
    case sisutekst
    case tavatekst
    case loige
    case loigeNr
    case kuvatavtekst
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
        case "kuvatavtekst", "kuvatavTekst", "KuvatavTekst":
            self = .kuvatavtekst
        case "loige":
            self = .loige
        case "loigeNr":
            self = .loigeNr
        default:
            return nil
        }
    }
}
