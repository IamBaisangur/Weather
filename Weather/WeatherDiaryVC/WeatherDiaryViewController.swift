//
//  WeatherDiary.swift
//  Weather
//
//  Created by Байсангур on 22.03.2023.
//

import Foundation
import UIKit

class WeatherDiaryViewController: UIViewController {
    
    private let tableView = UITableView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavBar()
        self.setupLayout()
        self.configureTable()
    }
}

private extension WeatherDiaryViewController {
    
    private func setupNavBar() {
        let image = UIImage(named: "edit")
        let navBarItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(self.onNewNoteButtonPressed))
        navBarItem.tintColor = .white
        self.navigationItem.rightBarButtonItem = navBarItem
    }
    
    @objc func onNewNoteButtonPressed() {
        let newNoteViewController = WeatherNoteViewControllerAssembly.build()
        self.navigationController?.pushViewController(newNoteViewController, animated: true)
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    func setupLayout() {
        
        let backgroundImageView = UIImageView(image: UIImage(named: "background"))
        self.view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: self.view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)])
        
        self.view.addSubview(self.tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)])
    }
    
    func configureTable() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.tableView.backgroundColor = .clear//UIColor(red: 1, green: 1, blue: 1, alpha: 0)
        self.tableView.register(WeatherNoteCell.self, forCellReuseIdentifier: WeatherNoteCell.identifier )
    }
}

extension WeatherDiaryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherNoteCell.identifier, for: indexPath) as? WeatherNoteCell else { return UITableViewCell()}
        return cell
    }
    
    
}

extension WeatherDiaryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let weatherNoteViewController = WeatherNoteViewControllerAssembly.build()
        self.present(weatherNoteViewController, animated: true)
    }
}
