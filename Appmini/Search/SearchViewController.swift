//
//  SearchViewController.swift
//  Appmini
//
//  Created by Woo on 8/9/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class SearchViewController : UIViewController {
    // 검색 (타이틀)
    let titleLabel : UILabel = {
        let label = UILabel()
        label.text = "검색"
        label.font = TextFont.labelFont
        label.textAlignment = .left
        label.textColor = ColorName.labelColor
        return label
    }()
    
    // searchBar
    let searchBar : UISearchBar = {
        let bar = UISearchBar()
        bar.placeholder = "Music"
        bar.searchTextField.font = TextFont.searchFont
        return bar
    }()
    
    // disposeBag
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        bind()
        
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .white
        backBarButtonItem.isEnabled = false
        self.navigationItem.backBarButtonItem = backBarButtonItem
    }
    
    private func bind() {
        
        searchBar.rx.searchButtonClicked
            .withLatestFrom(searchBar.rx.text.orEmpty)
            .bind(with: self) { owner, text in
                print("🍒 \(text)")
                let vc = ListViewController()
                vc.searchBar.text = text
                vc.text = text
                owner.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.height.equalTo(20)
        }
        
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)

        }
    }
}
