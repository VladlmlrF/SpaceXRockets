//
//  NetworkManager.swift
//  SpaceXRockets
//
//  Created by Владимир Фалин on 17.07.2022.
//

import UIKit

class NetworkManager {
    static func fetchRocketData(
        url: URL,
        indexPath: IndexPath,
        completion: @escaping (
            _ rocketName: String,
            _ rocketHeight: String,
            _ rocketDiameter: String,
            _ rocketMass: String
        ) -> ()
    ) {
        let session = URLSession.shared
        session.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let rockets = try decoder.decode([Rocket].self, from: data)
                guard let name = rockets[indexPath.row].name else { return }
                guard let height = rockets[indexPath.row].height?.meters else { return }
                guard let diameter = rockets[indexPath.row].diameter?.meters else { return }
                guard let mass = rockets[indexPath.row].mass?.kg else { return }
                var rocketName = ""
                var rocketHeight = ""
                var rocketDiameter = ""
                var rocketMass = ""
                DispatchQueue.main.async {
                    rocketName = name
                    rocketHeight = "Высота: \(height) м"
                    rocketDiameter = "Диаметр: \(diameter) м"
                    rocketMass = "Масса: \(mass) кг"
                    completion(
                        rocketName,
                        rocketHeight,
                        rocketDiameter,
                        rocketMass
                    )
                }
            } catch {
                print(error)
            }
        }.resume()
    }
    
    static func fetchRocketImage(
        url: URL,
        indexPath: IndexPath,
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
                guard let imageUrlStr = rockets[indexPath.row].flickrImages.first else { return }
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
}
