//
//  LaunchesTableViewController.swift
//  SpaceXRockets
//
//  Created by Владимир Фалин on 20.07.2022.
//

import UIKit

class LaunchesTableViewController: UITableViewController {

    let cellIndentifire = "Cell"
    
    var rocketLaunches: [RocketLaunches] = []
    
    private let label = UILabel()
    
    var counter = 0
    var rocketName = ""
    
    private let urlString = "https://api.spacexdata.com/v4/launches"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        title = rocketName

        tableView.register(LaunchesCell.self, forCellReuseIdentifier: cellIndentifire)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return counter
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIndentifire) as? LaunchesCell {
            cell.backgroundColor = .black
            cell.isUserInteractionEnabled = false
            
            let urlString = "https://api.spacexdata.com/v4/launches"
            guard let url = URL(string: urlString) else { return UITableViewCell() }
            let session = URLSession.shared
            session.dataTask(with: url) { data, response, error in
                guard let data = data else { return }
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let launches = try decoder.decode([RocketLaunches].self, from: data)
                    DispatchQueue.main.async {
                        guard let name = launches[indexPath.row].name else { return }
                        cell.launchNameLabel.text = name
                        
                        guard let date = launches[indexPath.row].dateLocal else { return }
                        cell.dateLabel.text = date
                        
                        guard let success = launches[indexPath.row].success else { return }
                        
                        if success {
                            cell.rocketImageView.image = UIImage(named: "good")
                        } else {
                            cell.rocketImageView.image = UIImage(named: "bad")
                        }
                    }
                    
                    
                } catch {
                    print(error)
                }
            }.resume()
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
}
