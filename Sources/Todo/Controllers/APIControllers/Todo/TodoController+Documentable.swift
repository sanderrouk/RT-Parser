import OpenApi
import Data

extension TodoController: Documentable {
    public static func defineDocumentation() {
        let index =
            OpenApi.defineAction(
                method: .get,
                route: "/api/v1/todos",
                summary: "Fetch TODO's.",
                description: "Used to create, fetch or delete todos related to a user.",
                responses: [
                    OpenApi.response(code: "200",
                                     description: "Successfully retruned all suitable todos.",
                                     array: Todo.self),

                    OpenApi.response(code: "500", description: "Something went wrong on the server side.")],
                authorization: true)

        let create =
            OpenApi.defineAction(
                method: .post,
                route: "/api/v1/todos",
                summary: "Create a Todo",
                description: "Create a Todo with the predefined title",
                request: OpenApi.request(
                    object: CreateTodoRequest.self,
                    description: "Create Todo Request",
                    contentType: "application/json"
                ),
                responses: [
                    OpenApi.response(
                        code: "200",
                        description: "Successfully created Todo",
                        object: Todo.self
                    ),

                    OpenApi.response(code: "500", description: "Something went wrong on the server side.")
                ], authorization: true)

        let delete =
            OpenApi.defineAction(
                method: .delete,
                route: "/api/v1/todos",
                summary: "Delete a Todo",
                description: "Delete a Todo with the id provided in the parameters.",
                parameters: [
                    OpenApi.parameter(
                        name: "Id",
                        parameterLocation: OpenApi.location.query,
                        description: "Id of the TODO",
                        required: true,
                        deprecated: false,
                        allowEmptyValue: false,
                        dataType: OpenApi.dataType.int32)
                ],
                authorization: true
        )

        OpenApi.defineController(
            name: "TODO Controller",
            description: "Create, Fetch and Delete TODO's.",
            actions: [index, create, delete])
    }
}
