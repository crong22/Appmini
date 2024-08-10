//
//  SearchViewModel.swift
//  Appmini
//
//  Created by Woo on 8/9/24.
//

import UIKit
import RxSwift
import RxCocoa

class SearchViewModel {
    
    let disposeBag = DisposeBag()
    
//    var record = UserDefaults.standard.stringArray(forKey: "record")
    
    var record : [String] = []
    
    struct Input {
        let searchBarClick : ControlEvent<Void>
        let searchBarText : ControlProperty<String>
    }
    
    struct Output {
        let searchBarClick : ControlEvent<Void>
        let recordList : BehaviorSubject<[String]>
    }
    
    func transform(input : Input) -> Output {

//        if let record = record {
            let searchList = BehaviorSubject(value: record)
            
            input.searchBarClick
                .withLatestFrom(input.searchBarText)
                .bind(with: self, onNext: { owner, text in
                    owner.record.insert(text, at: 0)
                    searchList.onNext(owner.record)
                    print("🍒🍒🍒🍒 \(text)")
                })
                .disposed(by: disposeBag)
            
            return Output(searchBarClick: input.searchBarClick, recordList: searchList)
//        }else {
//            let record : [String] = []
//            let searchList = BehaviorSubject(value: record)
//            input.searchBarClick
//                .withLatestFrom(input.searchBarText)
//                .bind(with: self, onNext: { owner, text in
//                    searchList.onNext([text])
//                    print("🍒🍒🍒🍒 \(text)")
//                })
//                .disposed(by: disposeBag)
//            
//            return Output(searchBarClick: input.searchBarClick, recordList: searchList)
//        }
    }
}
