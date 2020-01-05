enum LawElements: String {
    case subpoint
    case subpointNumber
    case contentText
    case regularText
    case section
    case sectionNumber
    case displayedText
    case paragraph
    case paragraphNumber
    case paragraphTitle
    case chapter
    case chapterNumber
    case chapterTitle
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
            self = .subpoint
        case "alampunktNr":
            self = .subpointNumber
        case "sisutekst", "sisuTekst", "SisuTekst":
            self = .contentText
        case "tavatekst", "tavaTekst", "TavaTekst":
            self = .regularText
        case "kuvatavtekst", "kuvatavTekst", "KuvatavTekst":
            self = .displayedText
        case "loige":
            self = .section
        case "loigeNr":
            self = .sectionNumber
        case "paragrahv":
            self = .paragraph
        case "paragrahvNr":
            self = .paragraphNumber
        case "paragrahvPealkiri":
            self = .paragraphTitle
        case "peatykk":
            self = .chapter
        case "peatykkNr":
            self = .chapterNumber
        case "peatykkPealkiri":
            self = .chapterTitle
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
