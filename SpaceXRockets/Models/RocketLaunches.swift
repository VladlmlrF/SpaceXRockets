//
//  RocketLaunches.swift
//  SpaceXRockets
//
//  Created by Владимир Фалин on 20.07.2022.
//

struct RocketLaunches: Decodable {
    var fairings: Fairings?
    var links: Links?
    var staticFireDateUtc: String?
    var staticFireDateUnix: Int?
    var net: Bool?
    var window: Int?
    var rocket: String?
    var success: Bool?
    var failures: [Failures?]?
    var details: String?
    var crew: [String?]?
    var ships: [String?]?
    var capsules: [String?]?
    var payloads: [String?]?
    var launchpad: String?
    var flightNumber: Int?
    var name: String?
    var dateUtc: String?
    var dateUnix: Int?
    var dateLocal: String?
    var datePrecision: String?
    var upcoming: Bool?
    var cores: [Cores?]?
    var autoUpdate: Bool?
    var tbd: Bool?
    var launchLibraryId: String?
    var id: String?
}

struct Cores: Decodable {
    var core: String?
    var flight: Int?
    var gridfins: Bool?
    var legs: Bool?
    var reused: Bool?
    var landingAttempt: Bool?
    var landingSuccess: Bool?
    var landingType: String?
    var landpad: String?
}

struct Failures: Decodable {
    var time: Int?
    var altitude: Int?
    var reason: String?
}

struct Links: Decodable {
    var patch: Patch?
    var reddit: Reddit?
    var flickr: Flickr?
    var presskit: String?
    var webcast: String?
    var youtubeId: String?
    var article: String?
    var wikipedia: String?
}

struct Patch: Decodable {
    var small: String?
    var large: String?
}

struct Reddit: Decodable {
    var campaign: String?
    var launch: String?
    var media: String?
    var recovery: String?
}

struct Flickr: Decodable {
    var small: [String?]?
    var original: [String?]?
}

struct Fairings: Decodable {
    var reused: Bool?
    var recoveryAttempt: Bool?
    var recovered: Bool?
    var ships: [String?]?
}
