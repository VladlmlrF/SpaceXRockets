//
//  RocketsTableViewController.swift
//  SpaceXRockets
//
//  Created by Владимир Фалин on 17.07.2022.
//

import UIKit

class RocketsTableViewController: UITableViewController {

    private let cellIndentifire = "RocketCell"
    private let urlString = "https://api.spacexdata.com/v4/rockets"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        changeNavBar()
        tableView.register(RocketTableViewCell.self, forCellReuseIdentifier: cellIndentifire)
    }
    
    // MARK: - Private methods
    
    private func changeNavBar() {
        title = "Rockets"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .black
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIndentifire) as? RocketTableViewCell {
            cell.backgroundColor = view.backgroundColor
            let backgroundColorView = UIView()
            backgroundColorView.backgroundColor = view.backgroundColor
            cell.selectedBackgroundView = backgroundColorView
            
            guard let url = URL(string: urlString) else { return UITableViewCell() }
            
            NetworkManager.fetchRocketImage(url: url, indexPath: indexPath) { rocketImage in
                cell.rocketImageView.image = rocketImage
            }
            
            NetworkManager.fetchRocketData(url: url, indexPath: indexPath) { rocketName, rocketHeight, rocketDiameter, rocketMass in
                cell.rocketNameLabel.text = rocketName
                cell.rocketHeightLabel.text = rocketHeight
                cell.rocketDiameterLabel.text = rocketDiameter
                cell.rocketMassLabel.text = rocketMass
            }
            return cell
        }
        return UITableViewCell()
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
}
