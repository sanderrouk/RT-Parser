# Let's Go Vapor
This is a Vapor template base off of the original https://github.com/vapor/auth-template. The difference being that this one has been modified to include more packages in the beginning (to help you get started faster) as well as has been split up into smaller individual parts.

## Usage:
In order to get up and running with this template first get the Vapor toolbox: https://docs.vapor.codes/3.0/getting-started/toolbox/

Then you can use it simply by executing the following command:
```bash
$ vapor new ProjectName --template=https://github.com/sanderrouk/lets-go-vapor # Where ProjectName is your project name
```

## Problems this template solves
The problems this template solves are the following:

### Separation of concerns
It splits the logic of the app into smaller targets allowing the separate logic of those targets to only deal with their own logic and exist separately from the rest of the code.

### Documentation
Vapor does not yet have support for out of the box API documentation. While they are working on adding a seamless support for documentation and the solution provided by this template is not ideal it is a solid step and works fine enough. An example documenetation has been implemented as well.

### A cleaner architecture
This template loosely follows the repository pattern provided in the Vapor docs [style guide](https://docs.vapor.codes/3.0/extras/style-guide/). The difference being the sub targets living on their own and dependency injection patterns handled a little differently. This helps keep code from piling up and helping you again seperate concerns.

## Additional Notes
There are some commented dependencies, most of them have to do with different db engines and are there so they could be easily used.

Additional plans for this include an example of using Leaf and potentially in the future of embedding a React app into the template.