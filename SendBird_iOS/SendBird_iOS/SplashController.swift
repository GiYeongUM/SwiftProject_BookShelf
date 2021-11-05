//
//  SplashController.swift
//  Sendbird_iOS
//
//  Created by 엄기영 on 2021/10/27.
//

import UIKit

var mainCVData : [Book] = Array()

class SplashController : UIViewController {
    
    @IBOutlet weak var splashImage: UIImageView!
    @IBOutlet weak var splashTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        splashTextAnimation()
        SearchController().getSearchBookList("Html", searchCompletionHandler: { data, error in
            if let result = data {
                mainCVData = result.books
            }
        })
    }

    fileprivate func splashTextAnimation(){
        splashTitle.textAlignment = NSTextAlignment.center
        splashImage.tintColor = UIColor.white
        view.backgroundColor = UIColor(named: "PrimaryBackGroundColor")
        UIView.animate(withDuration: 1.2, delay: 0.0, options: .curveEaseInOut, animations: {
            var splashTitleTopFrame = self.splashTitle.frame
            splashTitleTopFrame.origin.y -= splashTitleTopFrame.size.height
            self.splashTitle.frame = splashTitleTopFrame
            print(splashTitleTopFrame.origin.y)
        }, completion: { finished in
            self.splashImageTransition()
        })
    }
    
    fileprivate func splashImageTransition(){
        UIView.transition(with: self.splashImage, duration: 1.5, options: .transitionCrossDissolve, animations: {
            self.splashImage.isHidden = false;
        }, completion: { finished in
            DispatchQueue.main.async {
                sleep(2)
                let mainViewController = self.storyboard!.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
                self.navigationController?.pushViewController(mainViewController, animated: true)
            }
        })
    }
}
