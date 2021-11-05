//
//  SearchViewController.swift
//  SendBird_iOS
//
//  Created by 엄기영 on 2021/11/03.
//

import UIKit

class SearchViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    
    @IBOutlet weak var NavigationBar: UINavigationItem!
    @IBOutlet weak var searchTableView: UITableView!
    
    var searchBookData : [Book] = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NavigationBar.setHidesBackButton(false, animated: true)
        searchTableView.delegate = self
        searchTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchBookData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SearchTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
        
        let url = URL(string:searchBookData[indexPath.row].image)
        let imageUrl = try? Data(contentsOf: url!)
        cell.searchImage.image = UIImage(data: imageUrl!)
        cell.searchTitle.text = searchBookData[indexPath.row].title
        cell.searchSubTitle.text = searchBookData[indexPath.row].subtitle
        cell.searchIsbn.text = searchBookData[indexPath.row].isbn13
        cell.searchPrice.text = searchBookData[indexPath.row].price
        return cell
    }
    
}


