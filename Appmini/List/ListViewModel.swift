//
//  ListViewModel.swift
//  Appmini
//
//  Created by Woo on 8/9/24.
//

import UIKit
import RxSwift
import RxCocoa

class ListViewModel : BaseViewModel {
    
    let disposeBag = DisposeBag()

    struct Input {
        let recordText : BehaviorSubject<String>
    }
    
    struct Output {
        var musicList : Observable<[Result]>
    }

    func tranform(input: Input) -> Output {
        let musicTotalList = PublishSubject<[Result]>()

        input.recordText
            .take(1)
            .flatMap { value in
                NetworkManager.shared.callRequest(item: value)
            }
            .subscribe(with: self) { owner, music in
                musicTotalList.onNext(music.results)
            } onError: { owner, error in
                print("error : \(error)")
            } onCompleted: { owner in
                print("completed")
            } onDisposed: { owenr in
                print("disposed")
            }
            .disposed(by: disposeBag)
    

        return Output(musicList: musicTotalList)
    }
}


