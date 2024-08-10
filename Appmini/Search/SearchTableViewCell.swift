//
//  SearchTableViewCell.swift
//  Appmini
//
//  Created by Woo on 8/9/24.
//

import UIKit
import SnapKit

class SearchTableViewCell : UITableViewCell {
    
    let clockImage : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: <#T##String#>)
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    private func  configureUI() {
        contentView.backgroundColor = .white
        
        contentView.addSubview(<#T##view: UIView##UIView#>)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
