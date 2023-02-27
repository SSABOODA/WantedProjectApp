//
//  MainTableViewCell.swift
//  WantedProjectApp
//
//  Created by 한성봉 on 2023/02/21.
//

import UIKit

protocol LoadButtonTappedDelegate: AnyObject {
    func cellLoadButtonTapped()
}

final class MainTableViewCell: UITableViewCell {
    
    static let identifier = "TableViewCell"
    
    var mtvImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.tintColor = .systemBlue
        imgView.image = UIImage(systemName: "photo.artframe")
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    private var mtvProgressView: UIProgressView = {
       let pv = UIProgressView()
        pv.progressViewStyle = .bar
        pv.setProgress(0.5, animated: true)
        pv.trackTintColor = .lightGray
        pv.tintColor = .systemBlue
        pv.clipsToBounds = true
        pv.layer.cornerRadius = 3
        return pv
    }()
    
    lazy var mtvButton: UIButton = {
        let button = UIButton()
        button.setTitle("Load", for: .normal)
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(loadButtonTapped), for: .touchUpInside)
        return button
    }()
    
    

    // delegate pattern
    weak var delegate: LoadButtonTappedDelegate?
    
    var imageDataManager: ImageDataManager = ImageDataManager()
    var imgUrl: String?
    
    var basicImage = UIImage(systemName: "photo.artframe")
    
    var imageTagList: [Int] = []
    
    override func prepareForReuse() {
        super.prepareForReuse()
        print(#function)
        
        imageTagList = [4,3,2,1,0]
        
        mtvImageView.image = basicImage
        
        imageDataManager.setImageArray()
        imgUrl = imageDataManager.getImageArray(imageTagList[mtvImageView.tag])
        guard let imgUrl = imgUrl else { return }
        
        mtvImageView.setSyncImageUrl(imgUrl)
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        contentView.addSubview(mtvImageView)
        contentView.addSubview(mtvProgressView)
        contentView.addSubview(mtvButton)
        
        mtvImageView.translatesAutoresizingMaskIntoConstraints = false
        mtvProgressView.translatesAutoresizingMaskIntoConstraints = false
        mtvButton.translatesAutoresizingMaskIntoConstraints = false

        
        NSLayoutConstraint.activate([
            mtvImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            mtvImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            mtvImageView.heightAnchor.constraint(equalToConstant: 140),
            mtvImageView.widthAnchor.constraint(equalToConstant: 140),

            mtvProgressView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            mtvProgressView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -100),
            mtvProgressView.widthAnchor.constraint(equalToConstant: 125),
            mtvProgressView.heightAnchor.constraint(equalToConstant: 5),
            
            mtvButton.widthAnchor.constraint(equalToConstant: 90),
            mtvButton.heightAnchor.constraint(equalToConstant: 50),
            mtvButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            mtvButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
    
    
    @objc func loadButtonTapped(_ sender: UIButton) {
        print(#function)
        
        imageDataManager.setImageArray()
        imgUrl = imageDataManager.getImageArray(mtvImageView.tag)
        guard let imgUrl = imgUrl else { return }
        
        mtvImageView.image = basicImage
        
        switch mtvImageView.tag {
        case 0:
            mtvImageView.setImageUrl(imgUrl)
        case 1:
            mtvImageView.setImageUrl(imgUrl)
        case 2:
            mtvImageView.setImageUrl(imgUrl)
        case 3:
            mtvImageView.setImageUrl(imgUrl)
        case 4:
            mtvImageView.setImageUrl(imgUrl)
        default:
            break
            
        }
        
        delegate?.cellLoadButtonTapped()
    }
}


extension UIImageView {
    func setImageUrl(_ url: String) {
        DispatchQueue.global(qos: .background).async {
            usleep(350000)
            if let url = URL(string: url) {
                URLSession.shared.dataTask(with: url) { (data, res, err) in
                    if let _ = err {
                        DispatchQueue.main.async {
                            self.image = UIImage()
                        }
                        return
                    }
                    DispatchQueue.main.async {
                        if let data = data, let image = UIImage(data: data) {
                            self.image = image
                        }
                    }
                }.resume()
            }
        }
    }
    
    func setSyncImageUrl(_ url: String) {
        DispatchQueue.global(qos: .background).sync {
            if let url = URL(string: url) {
                URLSession.shared.dataTask(with: url) { (data, res, err) in
                    if let _ = err {
                        DispatchQueue.main.async {
                            self.image = UIImage()
                        }
                        return
                    }
                    DispatchQueue.main.sync {
                        usleep(50000)
                        if let data = data, let image = UIImage(data: data) {
                            self.image = image
                        }
                    }
                }.resume()
            }
        }
    }
 }
