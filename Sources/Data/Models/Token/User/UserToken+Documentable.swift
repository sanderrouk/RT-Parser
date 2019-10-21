import OpenApi

extension UserToken: Documentable {
    public static func defineDocumentation() {
        OpenApi.defineObject(object:
            UserToken(
                id: 1,
                string: "hash",
                userID: 1
            )
        )
    }
}
