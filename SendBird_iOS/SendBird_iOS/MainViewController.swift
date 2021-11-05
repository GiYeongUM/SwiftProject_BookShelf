//
//  ViewController.swift
//  Sendbird_iOS
//
//  Created by 엄기영 on 2021/10/27.
//

import UIKit

class MainViewController: UIViewController, UISearchBarDelegate, UICollectionViewDataSource, UICollectionViewDelegate,
                          UICollectionViewDelegateFlowLayout, UISearchControllerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var MainSearch: UISearchBar!
    @IBOutlet weak var MainCollection: UICollectionView!
    @IBOutlet weak var navigationBar: UINavigationItem!
    let splashController = SplashController()
    @IBOutlet weak var mainCollectionCon: NSLayoutConstraint!
    var searchController = UISearchController()
    
    @IBOutlet weak var recentSearchTable: UITableView!
    
    var recentSearchList : [String] = Array()
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return mainCVData.count
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recentSearchList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecentSearchTableViewCell", for: indexPath) as? RecentSearchTableViewCell else {
            return UITableViewCell()
        }
        let str = recentSearchList[indexPath.row]
        cell.recentSearchData.text = String(str)
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Maincell", for: indexPath) as? MainCollectionViewCell else {
            return UICollectionViewCell()
        }
        let url = URL(string:mainCVData[indexPath.row].image)
        let imageUrl = try? Data(contentsOf: url!)
        cell.cellImageView.image = UIImage(data: imageUrl!)
        return cell
    }
    
    
    
    func centerItemsInCollectionView(cellWidth: Double, numberOfItems: Double, spaceBetweenCell: Double, collectionView: UICollectionView) -> UIEdgeInsets {
        let totalWidth = cellWidth * numberOfItems
        let totalSpacingWidth = spaceBetweenCell * (numberOfItems - 1)
        let leftInset = (collectionView.frame.width - CGFloat(totalWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset
        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        recentSearchTable.isHidden = true
        let searchController = UISearchController(searchResultsController: nil)
        UINavigationBar.appearance().isTranslucent = false
        navigationBar.setHidesBackButton(true, animated: false)
        
        self.MainCollection.delegate = self
        self.MainCollection.dataSource = self
        
        let indexPath = IndexPath(row: mainCVData.count - 1, section: 0)
        self.MainCollection.insertItems(at: [indexPath])
        self.MainCollection.reloadData()
        
        recentSearchTable.delegate = self
        recentSearchTable.dataSource = self
        self.MainSearch.delegate = self
        navigationBar.titleView = MainSearch
        searchController.searchBar.delegate = self
        searchController.delegate = self
        searchController.obscuresBackgroundDuringPresentation = true
        mainSearchBarView()
        if let data = UserDefaults.standard.array(forKey: "searchData") as! [String]?{
            recentSearchList = data
        } else {
            recentSearchList = Array()
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        
        mainCollectionCon.constant = 10
        UIView.animate(withDuration: 0.8,
                       delay: 0,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 2,
                       options: .allowUserInteraction,
                       animations: {
            
            self.recentSearchTable.isHidden = true
            self.view.layoutIfNeeded()
        },
                       completion: nil)
        return true
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        
        mainCollectionCon.constant = 700
        UIView.animate(withDuration: 1.0,
                       delay: 0,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 2,
                       options: .allowUserInteraction,
                       animations: {
            self.recentSearchTable.isHidden = false
            self.view.layoutIfNeeded()
        },
                       completion: {_ in
            
           })
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        if(!MainSearch.text!.isEmpty){
            SearchController().getSearchBookList(searchBar.text!, searchCompletionHandler: { data, error in
                if let result = data {
                    
                    DispatchQueue.main.async {
                        self.recentSearchList.insert(self.MainSearch.text!, at: 0)
                        UserDefaults.standard.set(self.recentSearchList, forKey:"searchData")
                        let searchViewController = self.storyboard!.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
                        searchViewController.searchBookData = result.books
                        self.navigationController?.pushViewController(searchViewController, animated: true)
                        
                        self.recentSearchTable.reloadData()
                        
                    }
                }
            })
        }
    }
    
    
    fileprivate func mainSearchBarView(){
        MainSearch.layer.borderWidth = 0
        MainSearch.tintColor = UIColor.white
        MainSearch.barStyle = UIBarStyle.black
        MainSearch.searchTextField.backgroundColor = UIColor(named: "PrimaryBackGroundColor")
        MainSearch.searchTextField.textColor = UIColor.white
        MainSearch.searchTextField.clearButtonMode = .whileEditing
        MainSearch.returnKeyType = .search
        
        
        
        if let leftView = MainSearch.searchTextField.leftView as? UIImageView {
            leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
            leftView.tintColor = UIColor.white
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(searchImageTapped(tapGestureRecognizer:)))
            leftView.isUserInteractionEnabled = true
            leftView.addGestureRecognizer(tapGestureRecognizer)
        }
        
        
        
        if let clearButton = MainSearch.searchTextField.value(forKey: "_clearButton") as? UIButton {
            let templateImage =  clearButton.imageView?.image?.withRenderingMode(.alwaysTemplate)
            clearButton.setImage(templateImage, for: .normal)
            MainSearch.searchTextField.backgroundColor = UIColor(named: "PrimaryBackGroundColor")
            MainSearch.searchTextField.textColor = UIColor.white
            clearButton.tintColor = UIColor.white
        }
        MainSearch.barTintColor = UIColor.white
    }
    
    @objc func searchImageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        if(!MainSearch.text!.isEmpty){
            SearchController().getSearchBookList(MainSearch.text!, searchCompletionHandler: { data, error in
                if let result = data {
                    print(result.books)
                }
            })
            
        }
    }
}


class MainCollectionViewCell : UICollectionViewCell {
    
    @IBOutlet weak var cellImageView: UIImageView!
    
}

class RecentSearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var recentSearchData: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}




