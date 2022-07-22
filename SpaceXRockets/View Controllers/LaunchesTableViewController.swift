//
//  LaunchesTableViewController.swift
//  SpaceXRockets
//
//  Created by Владимир Фалин on 20.07.2022.
//

import UIKit

class LaunchesTableViewController: UITableViewController {

    private let cellIndentifire = "LaunchesCell"
    private let urlString = "https://api.spacexdata.com/v4/launches"
    
    var counter = 0
    var rocketName = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        title = rocketName

        tableView.register(LaunchesCell.self, forCellReuseIdentifier: cellIndentifire)
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        counter
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIndentifire) as? LaunchesCell {
            cell.backgroundColor = .black
            cell.isUserInteractionEnabled = false
            guard let url = URL(string: urlString) else { return UITableViewCell() }
            
            NetworkManager.fetchLaunchName(url: url, index: indexPath.row) { launchName in
                cell.launchNameLabel.text = launchName
            }
            
            NetworkManager.fetchLaunchDate(url: url, index: indexPath.row) { launchDate in
                cell.dateLabel.text = launchDate
            }
            
            NetworkManager.fetchLaunchImage(url: url, index: indexPath.row) { launchImage in
                cell.rocketImageView.image = launchImage
            }
            return cell
        }
        
        return UITableViewCell()
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
}
