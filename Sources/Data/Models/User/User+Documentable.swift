import OpenApi

extension User: Documentable {
    public static func defineDocumentation() {
        OpenApi.defineObject(object:
            User(
                id: 1,
                name: "John Smith",
                email: "john@example.com",
                passwordHash: "123123123"
            )
        )
    }
}
