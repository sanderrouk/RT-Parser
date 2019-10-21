import OpenApi
import Data

public func document() {
    let objects: [Documentable.Type] = [

    ]

    let controllers: [Documentable.Type] = [

    ]

    (objects + controllers).forEach { $0.defineDocumentation() }
}
