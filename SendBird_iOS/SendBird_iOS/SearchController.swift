//
//  SearchController.swift
//  SendBird_iOS
//
//  Created by 엄기영 on 2021/11/02.
//

import Foundation


class SearchController {
    
    var searchData: SearchData?
    let session: URLSession = URLSession.shared
    
    func getSearchBookList (_ name : String, searchCompletionHandler : @escaping (SearchData?, Error?) -> Void) {
        
        getSearch(url: URL(string: UriList.search + name)!, completionHandler: { data, response, error in
           
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                if let json = try? decoder.decode(SearchData.self, from: data) {
                    searchCompletionHandler(json, nil)
                }
            }
            catch let parseErr {
                print("Json Parsing Error", parseErr)
                searchCompletionHandler(nil, parseErr)
            }
        })
    
    }
    
    
    
    func getSearch(url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        session.dataTask(with: request, completionHandler: completionHandler).resume()
    }
}
