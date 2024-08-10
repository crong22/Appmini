//
//  SearchTableViewCell.swift
//  Appmini
//
//  Created by Woo on 8/9/24.
//

import UIKit
import SnapKit

class SearchTableViewCell : UITableViewCell {
    
    static var id = "SearchTableViewCell"
    
    let clockImage : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "clock.fill")
        image.tintColor = .blue
        image.contentMode = .center
        return image
    }()
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.font = TextFont.recordFont
        label.textAlignment = .left
        return label
    }()
    
    let xmarkButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    private func  configureUI() {
        contentView.backgroundColor = .white
        
        contentView.addSubview(clockImage)
        clockImage.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(5)
            make.height.width.equalTo(30)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(45)
            make.width.equalTo(150)
        }
        
        contentView.addSubview(xmarkButton)
        xmarkButton.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(5)
            make.height.width.equalTo(30)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
