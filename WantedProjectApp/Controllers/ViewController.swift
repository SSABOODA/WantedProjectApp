//
//  ViewController.swift
//  WantedProjectApp
//
//  Created by 한성봉 on 2023/02/21.
//

import UIKit


final class ViewController: UIViewController {
    
    // MARK: - Main 테이블 뷰

    private lazy var mainTableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 130
        tableView.separatorStyle = .none
        return tableView
    }()
    
    // MARK: - Load All Image Button

    private lazy var loadAllImageButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("Load All Images", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(loadAllButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var imageDataManager: ImageDataManager = ImageDataManager()
    
    var imgUrl: String = ""
    
    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.identifier)
        
        imageDataManager.setImageArray()
        
        setupUI()
    }
    
    // MARK: - setupUI

    func setupUI() {
        self.view.addSubview(mainTableView)
        self.view.addSubview(loadAllImageButton)
        
        
        mainTableView.translatesAutoresizingMaskIntoConstraints = false
        loadAllImageButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            mainTableView.topAnchor.constraint(equalTo: view.topAnchor),
            mainTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mainTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            loadAllImageButton.topAnchor.constraint(equalTo: mainTableView.topAnchor, constant: 720),
            loadAllImageButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            loadAllImageButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
            loadAllImageButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func loadAllButtonTapped(_ sender: UIButton) {
        print(#function)
        mainTableView.reloadData()
        
    }
    
}

// MARK: - TableView 확장

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageDataManager.loadImageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(#function)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier) as! MainTableViewCell
        
        cell.delegate = self

        // 셀 터치시 회색 비활성화
        cell.selectionStyle = .none
            
        // tag 번호 할당
        cell.mtvButton.tag = indexPath.row
        cell.mtvImageView.tag = indexPath.row
        
        return cell
    }
}


extension ViewController: LoadButtonTappedDelegate {
    func cellLoadButtonTapped() {
        print(#function)
    }
}
