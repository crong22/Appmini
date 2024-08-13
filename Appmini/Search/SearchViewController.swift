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
        backBarButtonItem.tintColor = .white
        backBarButtonItem.isEnabled = false
        self.navigationItem.backBarButtonItem = backBarButtonItem
    }
    
    
    private func bind() {
        guard let record = UserDefaults.standard.stringArray(forKey: "textRecord") else { return }
//        print("textRecord저장된 값",record)
        let recordRx = BehaviorSubject(value: record)
//        print("recordRx", recordRx)
        
        let input = SearchViewModel.Input(searchBarClick: searchBar.rx.searchButtonClicked, searchBarText: searchBar.rx.text.orEmpty, recordText: recordRx)
        let output = viewModel.tranform(input: input)
        
        
        output.searchBarClick
            .withLatestFrom(searchBar.rx.text.orEmpty)
            .bind(with: self) { owner, text in
                UserDefaults.standard.setValue(text, forKey: "record")
                let vc = ListViewController()
                vc.searchBar.text = text
                vc.text = text
                owner.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)
        

        output.recordList
            .bind(to: tableView.rx.items(cellIdentifier: SearchTableViewCell.id, cellType: SearchTableViewCell.self)) {(row, element,cell) in
                cell.titleLabel.text = element
                
//                cell.xmarkButton.rx.tap
//                    .bind(with: self, onNext: { owner, value in
//                        let removeList = owner.record.remove(at: row)
//                        UserDefaults.standard.setValue(removeList, forKey: "textRecord")
//                    })
//                    .disposed(by: self.disposeBag)
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
