import OpenApi

extension Todo: Documentable {
    public static func defineDocumentation() {
        OpenApi.defineObject(object:
            Todo(
                id: 1,
                title: "Todo 1",
                userID: 1
            )
        )
    }
}
