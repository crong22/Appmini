//
//  ListViewModel.swift
//  Appmini
//
//  Created by Woo on 8/9/24.
//

import UIKit
import RxSwift
import RxCocoa

class ListViewModel {
    
    let disposeBag = DisposeBag()

    struct Input {
        let searchBarButton : ControlEvent<Void>
        let searchBarText : ControlProperty<String>
    }
    
    struct Output {
        let searchBarButton : ControlEvent<Void>
        let musicList : Observable<[Result]>
    }
    
    func transform(inptut : Input) -> Output {
        let musicTotalList = PublishSubject<[Result]>()
        
        inptut.searchBarButton
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .withLatestFrom(inptut.searchBarText)
            .distinctUntilChanged()
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
    

        return Output(searchBarButton: inptut.searchBarButton, musicList: musicTotalList)
    }
}


