enum LawElements: String {
    case alampunkt
    case alampunktNr
    case sisutekst
    case tavatekst
    case loige
    case loigeNr
    case kuvatavtekst
    case paragrahv
    case paragrahvNr
    case paragrahvPealkiri
    case peatykk
    case peatykkNr
    case peatykkPealkiri
    case metadata
    case issuer
    case actType
    case textType
    case abbreviation
    case entryIntoForce
    case inForceFrom
    case inForceUntil
    case published
    case passed
    case title
    case legislation
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
        case "paragrahv":
            self = .paragrahv
        case "paragrahvNr":
            self = .paragrahvNr
        case "paragrahvPealkiri":
            self = .paragrahvPealkiri
        case "peatykk":
            self = .peatykk
        case "peatykkNr":
            self = .peatykkNr
        case "peatykkPealkiri":
            self = .peatykkPealkiri
        case "metaandmed":
            self = .metadata
        case "valjaandja":
            self = .issuer
        case "dokumentLiik":
            self = .actType
        case "tekstiliik":
            self = .textType
        case "lyhend":
            self = .abbreviation
        case "joustumine":
            self = .entryIntoForce
        case "kehtivuseAlgus":
            self = .inForceFrom
        case "kehtivuseLopp":
            self = .inForceUntil
        case "avaldamineKuupaev":
            self = .published
        case "aktikuupaev":
            self = .passed
        case "pealkiri":
            self = .title
        case "oigusakt":
            self = .legislation
        default:
            return nil
        }
    }
}
