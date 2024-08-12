//
//  SearchViewModel.swift
//  Appmini
//
//  Created by Woo on 8/9/24.
//

import UIKit
import RxSwift
import RxCocoa

class SearchViewModel : BaseViewModel {

    let disposeBag = DisposeBag()
    
    var record : [String] = []
    var recordList : [String] = []
    
    struct Input {
        let searchBarClick : ControlEvent<Void>
        let searchBarText : ControlProperty<String>
        let recordText : BehaviorSubject<[String]>
    }
    
    struct Output {
        let searchBarClick : ControlEvent<Void>
        let recordList : BehaviorSubject<[String]>
        let listRecord : BehaviorSubject<[String]>
    }
    
    func tranform(input: Input) -> Output {
        let searchList = BehaviorSubject(value: record)
        let listRecord = BehaviorSubject(value: recordList)
        
        input.searchBarClick
            .withLatestFrom(input.searchBarText)
            .bind(with: self, onNext: { owner, text in
                UserDefaults.standard.setValue(text, forKey: "text")
                guard let value = UserDefaults.standard.string(forKey: "text") else { return }
                print("value : \(value)")
                owner.record.insert(value, at: 0)
                UserDefaults.standard.setValue(owner.record, forKey: "textRecord")
                
                guard let textRecord = UserDefaults.standard.stringArray(forKey: "textRecord") else { return }
                print("textRecord : \(textRecord)")
                
                searchList.onNext(textRecord)
                
            })
            .disposed(by: disposeBag)
        
        input.recordText
            .bind(with: self) { owner, text in
                print("ttttttttext",text)
                listRecord.onNext(text)
            }
            .disposed(by: disposeBag)
        
        
        
        return Output(searchBarClick: input.searchBarClick, recordList: searchList, listRecord: listRecord)
    }
}
