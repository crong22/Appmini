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
    
    struct Input {
        let searchBarClick : ControlEvent<Void>
        let searchBarText : ControlProperty<String>
        let recordText : BehaviorSubject<[String]>
    }
    
    struct Output {
        let searchBarClick : ControlEvent<Void>
        let recordList : BehaviorSubject<[String]>
    }
    
    func tranform(input: Input) -> Output {
        var listRecord = UserDefaults.standard.stringArray(forKey: "textRecord") ?? []
        let listRecoerd = BehaviorSubject(value: listRecord)
            
        input.searchBarClick
            .withLatestFrom(input.searchBarText)
            .bind(with: self, onNext: { owner, text in
                UserDefaults.standard.setValue(text, forKey: "text")
                guard let value = UserDefaults.standard.string(forKey: "text") else { return }
                
                //중복 값 제거
                if listRecord.count > 0 {
                    for i in 0..<listRecord.count {
                        if listRecord[i] == value {
                            listRecord.remove(at: i)
                        }
                    }
                }
                
                listRecord.insert(value, at: 0)
                UserDefaults.standard.setValue(listRecord, forKey: "textRecord")
                
                guard let textRecord = UserDefaults.standard.stringArray(forKey: "textRecord") else { return }
                
                listRecoerd.onNext(textRecord)
            })
            .disposed(by: disposeBag)
        
        return Output(searchBarClick: input.searchBarClick, recordList: listRecoerd)
    }
}
