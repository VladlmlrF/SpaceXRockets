//
//  Rocket.swift
//  SpaceXRockets
//
//  Created by Владимир Фалин on 17.07.2022.
//

struct Rocket: Decodable {
    var height: Height?
    var diameter: Diameter?
    var mass: Mass?
    var firstStage: FirstStage?
    var secondStage: SecondStage?
    var engines: Engines?
    var landingLegs: LandingLegs?
    var payloadWeights: [PayloadWeight]?
    var flickrImages: [String?]
    var name: String?
    var type: String?
    var active: Bool?
    var stages: Int?
    var boosters: Int?
    var costPerLaunch: Int?
    var successRatePct: Int?
    var firstFlight: String?
    var country: String?
    var company: String?
    var wikipedia: String?
    var description: String?
    var id: String?
}

struct Height: Decodable {
    var meters: Double?
    var feet: Double?
}

struct Diameter: Decodable {
    var meters: Double?
    var feet: Double?
}

struct Mass: Decodable {
    var kg: Int?
    var lb: Int?
}

struct FirstStage: Decodable {
    var thrustSeaLevel: ThrustSeaLevel?
    var thrustVacuum: ThrustVacuum?
    var reusable: Bool?
    var engines: Int?
    var fuelAmountTons: Double?
    var burnTimeSec: Double?
}

struct ThrustSeaLevel: Decodable {
    var kN: Int?
    var lbf: Int?
}

struct ThrustVacuum: Decodable {
    var kN: Int?
    var lbf: Int?
}

struct SecondStage: Decodable {
    var thrust: Thrust?
    var payloads: Payloads?
    var reusable: Bool?
    var engines: Int?
    var fuelAmountTons: Double?
    var burnTimeSec: Int?
}

struct Thrust: Decodable {
    var kN: Int?
    var lbf: Int?
}

struct Payloads: Decodable {
    var compositeFairing: CompositeFairing?
    var option1: String?
}

struct CompositeFairing: Decodable {
    var height: Height?
    var diameter: Diameter?
}

struct Engines: Decodable {
    var isp: Isp?
    var thrustSeaLevel: ThrustSeaLevel?
    var thrustVacuum: ThrustVacuum?
    var number: Int?
    var type: String?
    var version: String?
    var layout: String?
    var engineLossMax: Int?
    var propellant1: String?
    var propellant2: String?
    var thrustToWeight: Double?
}

struct Isp: Decodable {
    var seaLevel: Int?
    var vacuum: Int?
}

struct LandingLegs: Decodable {
    var number: Int?
    var material: String?
}

struct PayloadWeight: Decodable {
    var id: String?
    var name: String?
    var kg: Int?
    var lb: Int?
}
