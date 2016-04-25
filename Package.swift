import PackageDescription

let package = Package(
    name: "Sideburns",
    dependencies: [
        .Package(url: "https://github.com/VeniceX/File.git", majorVersion: 0, minor: 5),
        .Package(url: "https://github.com/Zewo/HTTP.git", majorVersion: 0, minor: 5),
        .Package(url: "https://github.com/Zewo/Mustache.git", majorVersion: 0, minor: 5),
    ]
)
