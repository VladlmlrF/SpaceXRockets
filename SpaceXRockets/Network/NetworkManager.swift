//
//  NetworkManager.swift
//  SpaceXRockets
//
//  Created by Владимир Фалин on 17.07.2022.
//

import UIKit

class NetworkManager {
    
    // MARK: - rocket Name
    static func fetchRocketName(
        url: URL,
        index: Int,
        completion: @escaping (_ rocketName: String) -> ()
    ) {
        let session = URLSession.shared
        session.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let rockets = try decoder.decode([Rocket].self, from: data)
                guard let name = rockets[index].name else { return }
                var rocketName = ""
                DispatchQueue.main.async {
                    rocketName = name
                    completion(rocketName)
                }
            } catch {
                print(error)
            }
        }.resume()
    }
    
    // MARK: - rocket Height
    static func fetchRocketHeight(
        url: URL,
        index: Int,
        completion: @escaping (_ rocketHeight: String) -> ()
    ) {
        let session = URLSession.shared
        session.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let rockets = try decoder.decode([Rocket].self, from: data)
                guard let height = rockets[index].height?.meters else { return }
                var rocketHeight = ""
                DispatchQueue.main.async {
                    rocketHeight = "\(height)"
                    completion(rocketHeight)
                }
            } catch {
                print(error)
            }
        }.resume()
    }
    
    // MARK: - rocket Diameter
    static func fetchRocketDiameter(
        url: URL,
        index: Int,
        completion: @escaping (_ rocketDiameter: String) -> ()
    ) {
        let session = URLSession.shared
        session.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let rockets = try decoder.decode([Rocket].self, from: data)
                guard let diameter = rockets[index].diameter?.meters else { return }
                var rocketDiameter = ""
                DispatchQueue.main.async {
                    rocketDiameter = "\(diameter)"
                    completion(rocketDiameter)
                }
            } catch {
                print(error)
            }
        }.resume()
    }
    
    // MARK: - rocket Mass
    static func fetchRocketMass(
        url: URL,
        index: Int,
        completion: @escaping (_ rocketMass: String) -> ()
    ) {
        let session = URLSession.shared
        session.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let rockets = try decoder.decode([Rocket].self, from: data)
                guard let mass = rockets[index].mass?.kg else { return }
                var rocketMass = ""
                DispatchQueue.main.async {
                    rocketMass = "\(mass)"
                    completion(rocketMass)
                }
            } catch {
                print(error)
            }
        }.resume()
    }
    
    // MARK: - rocket Image
    static func fetchRocketImage(
        url: URL,
        index: Int,
        completion: @escaping (
            _ rocketImage: UIImage
        ) -> ()
    ) {
        let session = URLSession.shared
        session.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let rockets = try decoder.decode([Rocket].self, from: data)
                guard let imageUrlStr = rockets[index].flickrImages.first else { return }
                guard let imageUrl = URL(string: imageUrlStr ?? "") else { return }
                URLSession.shared.dataTask(with: imageUrl) { data, _, _ in
                    if let imageData = data, let image = UIImage(data: imageData) {
                        var rocketImage = UIImage()
                        DispatchQueue.main.async {
                            rocketImage = image
                            completion(rocketImage)
                        }
                    }
                }.resume()
            } catch let error {
                print(error)
            }
        }.resume()
    }
    
    // MARK: - rocket First Flight
    static func fetchRocketFirstStart(
        url: URL,
        index: Int,
        completion: @escaping (_ rocketFirstStart: String) -> ()
    ) {
        let session = URLSession.shared
        session.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let rockets = try decoder.decode([Rocket].self, from: data)
                guard let firstStart = rockets[index].firstFlight else { return }
                var rocketFirstStart = ""
                let editedDate = firstStart.split(separator: "-").reversed().joined(separator: ".")
                DispatchQueue.main.async {
                    rocketFirstStart = editedDate
                    completion(rocketFirstStart)
                }
            } catch {
                print(error)
            }
        }.resume()
    }
    
    // MARK: - rocket First Flight Country
    static func fetchFirstStartCountry(
        url: URL,
        index: Int,
        completion: @escaping (_ firstStartCountry: String) -> ()
    ) {
        let session = URLSession.shared
        session.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let rockets = try decoder.decode([Rocket].self, from: data)
                guard let country = rockets[index].country else { return }
                var firstStartCountry = ""
                DispatchQueue.main.async {
                    if country == "United States" {
                        firstStartCountry = "США"
                    } else if country == "Republic of the Marshall Islands" {
                        firstStartCountry = "Маршалловы острова"
                    }
                    completion(firstStartCountry)
                }
            } catch {
                print(error)
            }
        }.resume()
    }
    
    // MARK: - rocket First Flight Cost
    static func fetchFirstStartCost(
        url: URL,
        index: Int,
        completion: @escaping (_ cost: String) -> ()
    ) {
        let session = URLSession.shared
        session.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let rockets = try decoder.decode([Rocket].self, from: data)
                guard let cost = rockets[index].costPerLaunch else { return }
                var firstStartCost = ""
                DispatchQueue.main.async {
                    firstStartCost = "$\(cost / 1000000) млн"
                    completion(firstStartCost)
                }
            } catch {
                print(error)
            }
        }.resume()
    }
    
    // MARK: - rocket First Stage Engines
    static func fetchFirstStageEngine(
        url: URL,
        index: Int,
        completion: @escaping (_ firstStageEngines: String) -> ()
    ) {
        let session = URLSession.shared
        session.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let rockets = try decoder.decode([Rocket].self, from: data)
                guard let engines = rockets[index].firstStage?.engines else { return }
                var firstStageEngines = ""
                DispatchQueue.main.async {
                    firstStageEngines = "\(engines)"
                    completion(firstStageEngines)
                }
            } catch {
                print(error)
            }
        }.resume()
    }
    
    // MARK: - rocket First Stage Fuels
    static func fetchFirstStageFuels(
        url: URL,
        index: Int,
        completion: @escaping (_ firstStageFuels: String) -> ()
    ) {
        let session = URLSession.shared
        session.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let rockets = try decoder.decode([Rocket].self, from: data)
                guard let fuels = rockets[index].firstStage?.fuelAmountTons else { return }
                var firstStageFuels = ""
                DispatchQueue.main.async {
                    firstStageFuels = "\(fuels)"
                    completion(firstStageFuels)
                }
            } catch {
                print(error)
            }
        }.resume()
    }
    
    // MARK: - rocket First Stage Burn
    static func fetchFirstStageBurn(
        url: URL,
        index: Int,
        completion: @escaping (_ firstStageBurn: String) -> ()
    ) {
        let session = URLSession.shared
        session.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let rockets = try decoder.decode([Rocket].self, from: data)
                guard let burn = rockets[index].firstStage?.burnTimeSec else { return }
                var firstStageBurn = ""
                DispatchQueue.main.async {
                    firstStageBurn = "\(burn)"
                    completion(firstStageBurn)
                }
            } catch {
                print(error)
            }
        }.resume()
    }
    
    // MARK: - rocket Second Stage Engines
    static func fetchSecondStageEngine(
        url: URL,
        index: Int,
        completion: @escaping (_ secondStageEngines: String) -> ()
    ) {
        let session = URLSession.shared
        session.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let rockets = try decoder.decode([Rocket].self, from: data)
                guard let engines = rockets[index].secondStage?.engines else { return }
                var secondStageEngines = ""
                DispatchQueue.main.async {
                    secondStageEngines = "\(engines)"
                    completion(secondStageEngines)
                }
            } catch {
                print(error)
            }
        }.resume()
    }
    
    // MARK: - rocket Second Stage Fuels
    static func fetchSecondStageFuels(
        url: URL,
        index: Int,
        completion: @escaping (_ secondStageFuels: String) -> ()
    ) {
        let session = URLSession.shared
        session.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let rockets = try decoder.decode([Rocket].self, from: data)
                guard let fuels = rockets[index].secondStage?.fuelAmountTons else { return }
                var secondStageFuels = ""
                DispatchQueue.main.async {
                    secondStageFuels = "\(fuels)"
                    completion(secondStageFuels)
                }
            } catch {
                print(error)
            }
        }.resume()
    }
    
    // MARK: - rocket Second Stage Burn
    static func fetchSecondStageBurn(
        url: URL,
        index: Int,
        completion: @escaping (_ secondStageBurn: String) -> ()
    ) {
        let session = URLSession.shared
        session.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let rockets = try decoder.decode([Rocket].self, from: data)
                guard let burn = rockets[index].secondStage?.burnTimeSec else { return }
                var secondStageBurn = ""
                DispatchQueue.main.async {
                    secondStageBurn = "\(burn)"
                    completion(secondStageBurn)
                }
            } catch {
                print(error)
            }
        }.resume()
    }
    
    // MARK: - rocket Launch Name
    static func fetchLaunchName(
        url: URL,
        index: Int,
        completion: @escaping (_ launchName: String) -> ()
    ) {
        let session = URLSession.shared
        session.dataTask(with: url) { data, _, error in
            guard let data = data else { return }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let launches = try decoder.decode([RocketLaunches].self, from: data)
                guard let name = launches[index].name else { return }
                var launchName = ""
                DispatchQueue.main.async {
                    launchName = name
                    completion(launchName)
                }
            } catch {
                print(error)
            }
        }.resume()
    }
    
    // MARK: - rocket Launch Date
    static func fetchLaunchDate(
        url: URL,
        index: Int,
        completion: @escaping (_ launchDate: String) -> ()
    ) {
        let session = URLSession.shared
        session.dataTask(with: url) { data, _, error in
            guard let data = data else { return }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let launches = try decoder.decode([RocketLaunches].self, from: data)
                guard let date = launches[index].dateLocal else { return }
                var editedDate = date
                if editedDate.count >= 15 {
                    editedDate.removeLast(15)
                }
                var launchDate = ""
                DispatchQueue.main.async {
                    launchDate = editedDate.split(separator: "-").reversed().joined(separator: ".")
                    completion(launchDate)
                }
            } catch {
                print(error)
            }
        }.resume()
    }
    
    //MARK: - rocket Launch Image
    static func fetchLaunchImage(
        url: URL,
        index: Int,
        completion: @escaping (_ launchImage: UIImage) -> ()
    ) {
        let session = URLSession.shared
        session.dataTask(with: url) { data, _, error in
            guard let data = data else { return }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let launches = try decoder.decode([RocketLaunches].self, from: data)
                guard let success = launches[index].success else { return }
                var launchImage = UIImage()
                DispatchQueue.main.async {
                    if success {
                        launchImage = UIImage(named: "good") ?? UIImage()
                    } else {
                        launchImage = UIImage(named: "bad") ?? UIImage()
                    }
                    completion(launchImage)
                }
            } catch {
                print(error)
            }
        }.resume()
    }
}
