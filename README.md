# Riigiteataja Parser
[![CI Status](https://github.com/sanderrouk/rt-parser/workflows/Build%20and%20test/badge.svg)](https://github.com/sanderrouk/rt-parser/actions)

Riigiteataja parser (RT-Parser) is a simple API which can be used as an intermediary between your app or service and the Estonian legislative portal, Riigiteatja. RT-Parser takes the XML of a legislative act provided by Riigiteataja and converts it to JSON. The internal cache of the service is updated on 12 hour interwals. 

RT-Parser can be hosted on any docker host meaning you can incorporate it into your development and production environments with ease.

**Production - v0.1:** https://rtparser.herokuapp.com

**Staging - master:** https://rt-parser-staging.herokuapp.com

**API Documentation:** https://rtparser.herokuapp.com/docs

### Usage
There are multiple ways to use the service, for all methods the API is always documented. The most recent version of the documentation can be found at: https://rtparser.herokuapp.com/docs

After hosting the service or using the prehosted one you can point any of your API consumers towards your desired RT-Parser API.

#### Using the publicly hosted API
One of the easiest versions to use the service is to use the API hosted by us at:
https://rtparser.herokuapp.com However this method is only great for getting started on development as this is the smallest Heroku Dyno (Hobby) meaning that the service will shut down after 30 minutes of being idle and it also does not scale to large amounts of traffic.

#### Hosting your own
At this time for production we recommend hosting your own copy of the service. This can be done on any platform which is capable of running Swift at the version seen in `.swift-version`. As the service does not have any external dependencies, meaning no databases or anything else required, it can simply be ran using swift:

```bash
$ swift run
```

#### Hosting your own using Docker
While the service can be run on any host which is capable of running Swift it does bring its own limitations, such as not being containerised or not being able to run on Window's host. These are some of the reasons you might wish to host this service using Docker. We recommend to host the service using the included `web.Dockerfile` or by building your own Dockerfile. 

```bash
$ docker build . -f web.Dockerfile -t rt-parser:latest
$ docker run rt-parser:latest
```

#### Hosting using the latest Docker Hub image
Coming soon

### Support
If you find an issue with the RT-Parser then feel free to open an issue on GitHub and the issue will be addressed as soon as possible. Do keep in mind that this project may not handle all the issues with Riigiteataja's XML and reporting them will help patch things up.

### Roadmap
The roadmap of the project is very limited. 

#### V1.0
* Handle laws with uncategorised paragraphs.
* Cache all laws on sync.
* Add Docker Hub image.

### Contributing
Contributions to the project are welcome using pull requests.

### Authors and acknowledgment
Developers of this project: 
* Agnes Kuus
* Sander Rõuk

### License
This project is licenced under the MIT licence.

### Project status
The current state of the project is considered version 0.1 meaning that it is quite not ready yet to be considered 1.0. With that said the current state is already usable and moving from version 0.1 to version 1.0 will not bring any drastic changes.
