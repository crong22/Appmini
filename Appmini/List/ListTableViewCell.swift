//
//  ListTableViewCell.swift
//  Appmini
//
//  Created by Woo on 8/9/24.
//

import UIKit
import SnapKit

class ListTableViewCell : UITableViewCell {
    static let id = "ListTableViewCell"
    // 앨범표지
    let albumView : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        return image
    }()
    
    // 노래제목
    let musicLabel : UILabel = {
        let label = UILabel()
        label.text = "Congratulations"
        label.font = TextFont.musicFont
        label.textAlignment = .left
        return label
    }()
    
    // 가수
    let artistLabel : UILabel = {
        let label = UILabel()
        label.text = "DAY6"
        label.font = TextFont.artistFont
        label.textAlignment = .left
        return label
    }()
    
    // 상세정보
    let detailButton : UIButton = {
        let button = UIButton()
        button.setTitle("정보", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 2
        button.layer.borderColor = .init(red: 0/255, green: 0/255, blue: 139/255, alpha: 1)
        button.backgroundColor = .systemBlue
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    private func configureUI() {
        contentView.backgroundColor = .white
        
        albumView.backgroundColor = .blue
        contentView.addSubview(albumView)
        albumView.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(5)
            make.height.equalTo(70)
            make.width.equalTo(70)
        }
        
        contentView.addSubview(musicLabel)
        musicLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(17)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(85)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(55)
            make.height.equalTo(35)
        }
        
        contentView.addSubview(artistLabel)
        artistLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(47)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(85)
            make.height.equalTo(20)
        }
        
        contentView.addSubview(detailButton)
        detailButton.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(5)
            make.width.equalTo(50)
            make.height.equalTo(30)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
