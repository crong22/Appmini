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
    
    // tableView
    let tableView = UITableView()
    
    // disposeBag
    let disposeBag = DisposeBag()
    
    // viewModel
    let viewModel = SearchViewModel()
    
    //
    var record : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        bind()
        
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .black
        backBarButtonItem.isEnabled = true
        self.navigationItem.backBarButtonItem = backBarButtonItem
    }
    
    private func bind() {
        let record = UserDefaults.standard.stringArray(forKey: "textRecord") ?? []

        let recordRx = BehaviorSubject(value: record)
        print("record 🍏",record)
        print("recordRx 🍒", recordRx)
        
        let input = SearchViewModel.Input(searchBarClick: searchBar.rx.searchButtonClicked, searchBarText: searchBar.rx.text.orEmpty, recordText: recordRx)
        let output = viewModel.tranform(input: input)
        
        
        output.searchBarClick
            .withLatestFrom(searchBar.rx.text.orEmpty)
            .bind(with: self) { owner, text in
                print("searchBarClick 실행")
                UserDefaults.standard.setValue(text, forKey: "record")
                let vc = ListViewController()
                vc.text = text
                owner.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)
        

        output.recordList
            .bind(to: tableView.rx.items(cellIdentifier: SearchTableViewCell.id, cellType: SearchTableViewCell.self)) {(row, element,cell) in
                cell.titleLabel.text = element
                print("recordList")
            }
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .bind(with: self) { owner, value in
                print(record[value.row])
                let vc = ListViewController()
                vc.text = record[value.row]
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
        
        view.addSubview(tableView)
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.id)
        tableView.rowHeight = 40
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(10)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
    }
}
