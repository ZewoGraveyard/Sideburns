import PackageDescription

let package = Package(
    name: "Sideburns",
    dependencies: [
        .Package(url: "https://github.com/Zewo/HTTP.git", majorVersion: 0),
		.Package(url: "https://github.com/Zewo/Mustache.git", majorVersion: 0)
    ]
)
