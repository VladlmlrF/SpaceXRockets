//
//  DetailsViewController.swift
//  SpaceXRockets
//
//  Created by Владимир Фалин on 17.07.2022.
//

import UIKit

class DetailsViewController: UIViewController {

    private let rocketImageView = UIImageView()
    private let backgroundView = UIView()
    private let rocketNameLabel = UILabel()
    private let tableView = UITableView()
    private let showLaunchesButton = UIButton(type: .roundedRect)
    
    private let cellIndentifire = "DetailCell"
    private let launchUrlString = "https://api.spacexdata.com/v4/launches"
    
    private let sectionNames = [
        "ХАРАКТЕРИСТИКИ",
        "ПЕРВЫЙ ЗАПУСК",
        "ПЕРВАЯ СТУПЕНЬ",
        "ВТОРАЯ СТУПЕНЬ"
    ]
    
    private var counter = 0
    var urlString = ""
    var index = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        changeNavBar()
        setupRocketImageView()
        setupBackgroundView()
        setupRocketNameLabel()
        setupTableView()
        
        fetchData()
        fetchDataToLaunch()
    }
    
    // MARK: - Private methods
    private func setupRocketImageView() {
        rocketImageView.frame = CGRect(
            x: 0,
            y: navigationController?.navigationBar.frame.height ?? 0,
            width: view.frame.width,
            height: view.frame.height * 0.5
        )
        rocketImageView.contentMode = .scaleToFill
        rocketImageView.backgroundColor = .black
        view.addSubview(rocketImageView)
    }
    
    private func setupBackgroundView() {
        let backgroundViewOriginY = view.frame.height * 0.5 - 30 + (navigationController?.navigationBar.frame.height ?? 0)
        backgroundView.frame = CGRect(
            x: 0,
            y: backgroundViewOriginY,
            width: view.frame.width,
            height: view.frame.height - backgroundViewOriginY + 30
        )
        backgroundView.backgroundColor = .black
        backgroundView.layer.cornerRadius = 30
        view.addSubview(backgroundView)
    }
    
    private func setupRocketNameLabel() {
        rocketNameLabel.frame = CGRect(
            x: 30,
            y: 10,
            width: view.frame.width / 2,
            height: 30
        )
        rocketNameLabel.font = .boldSystemFont(ofSize: 24)
        rocketNameLabel.textColor = .white
        rocketNameLabel.adjustsFontSizeToFitWidth = true
        backgroundView.addSubview(rocketNameLabel)
    }
    
    private func setupTableView() {
        tableView.register(
            DetailsTableViewCell.self,
            forCellReuseIdentifier: cellIndentifire
        )
        tableView.frame = CGRect(
            x: 0,
            y: 40,
            width: backgroundView.frame.width,
            height: backgroundView.frame.height - 40
        )
        tableView.backgroundColor = .black
        tableView.delegate = self
        tableView.dataSource = self
        backgroundView.addSubview(tableView)
    }
    
    private func changeNavBar() {
        title = "Подробности"
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
    
    private func fetchData() {
        guard let url = URL(string: urlString) else { return }
        NetworkManager.fetchRocketImage(url: url, index: index) { rocketImage in
            self.rocketImageView.image = rocketImage
        }

        NetworkManager.fetchRocketName(url: url, index: index) { rocketName in
            self.rocketNameLabel.text = rocketName
        }
    }
    
    private func fetchDataToLaunch() {

        guard let url = URL(string: launchUrlString) else { return }

        let session = URLSession.shared
        session.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let launches = try decoder.decode([RocketLaunches].self, from: data)
                DispatchQueue.main.async {
                    guard let rocketName = self.rocketNameLabel.text else { return }
                    if rocketName == "Falcon 1" {
                        self.counter = 0
                        for launch in launches {
                            if launch.rocket == "5e9d0d95eda69955f709d1eb" {
                                self.counter += 1
                            }
                        }
                    } else if rocketName == "Falcon 9" {
                        self.counter = 0
                        for launch in launches {
                            if launch.rocket == "5e9d0d95eda69973a809d1ec" {
                                self.counter += 1
                            }
                        }
                    } else if rocketName == "Falcon Heavy" {
                        self.counter = 0
                        for launch in launches {
                            if launch.rocket == "5e9d0d95eda69974db09d1ed" {
                                self.counter += 1
                            }
                        }
                    } else if rocketName == "Starship" {
                        self.counter = 0
                        for launch in launches {
                            if launch.rocket == "5e9d0d96eda699382d09d1ee" {
                                self.counter += 1
                            }
                        }
                    }
                }

            } catch {
                print(error)
            }
        }.resume()
    }
    
    @objc func toLaunches() {
        let launchesVC = LaunchesTableViewController()
        navigationController?.pushViewController(launchesVC, animated: true)
        guard let rocketName = rocketNameLabel.text else { return }
        
        launchesVC.rocketName = rocketName
        launchesVC.counter = self.counter
    }
}

// MARK: - Table view delegate
extension DetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .black
        if let header = view as? UITableViewHeaderFooterView {
            header.textLabel?.textColor = .lightGray
            header.textLabel?.font = .boldSystemFont(ofSize: 18)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 3 {
            return 160
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 100)
        footerView.backgroundColor = .black
        showLaunchesButton.frame = CGRect(x: 0, y: 30, width: footerView.frame.width - 60, height: 60)
        showLaunchesButton.center.x = footerView.center.x
        showLaunchesButton.setTitle("Посмотреть запуски", for: .normal)
        showLaunchesButton.setTitleColor(.white, for: .normal)
        showLaunchesButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        showLaunchesButton.layer.cornerRadius = 20
        showLaunchesButton.backgroundColor = .darkGray
        showLaunchesButton.addTarget(self, action: #selector(toLaunches), for: .touchUpInside)
        footerView.addSubview(showLaunchesButton)
        return footerView
    }
}

// MARK: - Table view data source
extension DetailsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sectionNames.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIndentifire) as? DetailsTableViewCell {
            cell.backgroundColor = .black
            guard let url = URL(string: urlString) else { return UITableViewCell()}
            
            if indexPath.section == 0 {
                switch indexPath.row {
                case 0:
                    cell.propertyNameLabel.text = "Высота, м"
                    NetworkManager.fetchRocketHeight(url: url, index: index) { rocketHeight in
                        cell.propertyValueLabel.text = rocketHeight
                    }
                case 1:
                    cell.propertyNameLabel.text = "Диаметр, м"
                    NetworkManager.fetchRocketDiameter(url: url, index: index) { rocketDiameter in
                        cell.propertyValueLabel.text = rocketDiameter
                    }
                case 2:
                    cell.propertyNameLabel.text = "Масса, кг"
                    NetworkManager.fetchRocketMass(url: url, index: index) { rocketMass in
                        cell.propertyValueLabel.text = rocketMass
                    }
                default:
                    break
                }
            } else if indexPath.section == 1 {
                switch indexPath.row {
                case 0:
                    cell.propertyNameLabel.text = "Дата первого запуска"
                    NetworkManager.fetchRocketFirstStart(url: url, index: index) { rocketFirstStart in
                        cell.propertyValueLabel.text = rocketFirstStart
                    }
                case 1:
                    cell.propertyNameLabel.text = "Страна"
                    NetworkManager.fetchFirstStartCountry(url: url, index: index) { firstStartCountry in
                        cell.propertyValueLabel.text = firstStartCountry
                    }
                case 2:
                    cell.propertyNameLabel.text = "Стоимость запуска"
                    NetworkManager.fetchFirstStartCost(url: url, index: index) { cost in
                        cell.propertyValueLabel.text = cost
                    }
                default:
                    break
                }
            } else if indexPath.section == 2 {
                switch indexPath.row {
                case 0:
                    cell.propertyNameLabel.text = "Количество двигателей"
                    NetworkManager.fetchFirstStageEngine(url: url, index: index) { firstStageEngines in
                        cell.propertyValueLabel.text = firstStageEngines
                    }
                case 1:
                    cell.propertyNameLabel.text = "Количество топлива, тонн"
                    NetworkManager.fetchFirstStageFuels(url: url, index: index) { firstStageFuels in
                        cell.propertyValueLabel.text = firstStageFuels
                    }
                case 2:
                    cell.propertyNameLabel.text = "Время сгорания, с"
                    NetworkManager.fetchFirstStageBurn(url: url, index: index) { firstStageBurn in
                        cell.propertyValueLabel.text = firstStageBurn
                    }
                default:
                    break
                }
            } else if indexPath.section == 3 {
                switch indexPath.row {
                case 0:
                    cell.propertyNameLabel.text = "Количество двигателей"
                    NetworkManager.fetchSecondStageEngine(url: url, index: index) { secondStageEngines in
                        cell.propertyValueLabel.text = secondStageEngines
                    }
                case 1:
                    cell.propertyNameLabel.text = "Количество топлива, тонн"
                    NetworkManager.fetchSecondStageFuels(url: url, index: index) { secondStageFuels in
                        cell.propertyValueLabel.text = secondStageFuels
                    }
                case 2:
                    cell.propertyNameLabel.text = "Время сгорания, с"
                    NetworkManager.fetchSecondStageBurn(url: url, index: index) { secondStageBurn in
                        cell.propertyValueLabel.text = secondStageBurn
                    }
                default:
                    break
                }
            }
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sectionNames[section]
    }
}
