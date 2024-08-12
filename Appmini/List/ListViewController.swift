//
//  ListViewController.swift
//  Appmini
//
//  Created by Woo on 8/9/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Kingfisher

final class ListViewController : UIViewController {
    
    var text = ""
    
    // searchBar
    let searchBar : UISearchBar = {
        let bar = UISearchBar()
        bar.placeholder = "Music"
        bar.searchTextField.font = TextFont.searchFont
        return bar
    }()
    
    // tableView
    let tableView = UITableView()
    
    // model
    let viewModel = ListViewModel()
    
    // disposeBag
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 뒤로가기버튼삭제 및 searchBar
        navigationItem.titleView = searchBar
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: UIView())

        configureUI()
        bind()
    }
    
    private func bind() {
        
        let input = ListViewModel.Input(searchBarButton: searchBar.rx.searchButtonClicked, searchBarText: searchBar.rx.text.orEmpty)
        let output = viewModel.tranform(input: input)
        
        output.musicList
            .bind(to: tableView.rx.items(cellIdentifier: ListTableViewCell.id, cellType: ListTableViewCell.self)) {(row, element,cell) in
                guard let image = URL(string: element.artworkUrl100!) else {
                    return
                }
                cell.albumView.kf.setImage(with: image)
                cell.musicLabel.text = element.trackName
                cell.artistLabel.text = element.artistName
            }
            .disposed(by: disposeBag)

    }
    
    private func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.id)
        tableView.rowHeight = 100
        tableView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(15)
        }
        
    }
}
