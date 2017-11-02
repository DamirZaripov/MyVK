//
//  NewsRepository.swift
//  MyVK
//
//  Created by Дамир Зарипов on 30.10.17.
//  Copyright © 2017 itisioslab. All rights reserved.
//

import Foundation

class NewsRepository: RepositoryProtocol {
    
    typealias T = News
    public var news = [News]()
    
    static let instance = NewsRepository()
    
    private init() {}
    
    func synsSave(with news: News) {
        self.news.append(news)
    }
    
    func asynSave(with news: News, complitionBlock: @escaping (Bool) -> ()) {
        let operationQueue = OperationQueue()
        operationQueue.addOperation { [weak self] in
            guard let strongSelf = self else {return}
            strongSelf.news.append(news)
            complitionBlock(true)
        }
        complitionBlock(false)
    }
    
    func syncGetAll() -> [News] {
        return news
    }
    
    func asynGetAll(complitionBlock: @escaping ([News]) -> ()) {
        let operationQueue = OperationQueue()
        operationQueue.addOperation { [weak self] in
            guard let strongSelf = self else {return}
            let newsArray = strongSelf.syncGetAll()
            complitionBlock(newsArray)
        }
    }
    
    func syncSearch(by id: Int) -> News? {
        return news.first(where: { $0.id == id })
    }
    
    func asynSearch(by id: Int, complitionBlock: @escaping (News?) -> ()) {
        let operationQueue = OperationQueue()
        operationQueue.addOperation { [weak self] in
            guard let strongSelf = self else {return}
            let resultNews: News? = strongSelf.news.first(where: { $0.id == id })
            complitionBlock(resultNews)
        }
        complitionBlock(nil)
    }
    
       
}

