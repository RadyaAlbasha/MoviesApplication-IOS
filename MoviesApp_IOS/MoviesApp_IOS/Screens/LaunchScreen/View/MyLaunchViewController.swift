//
//  MyLaunchViewController.swift
//  MoviesApp_IOS
//
//  Created by Esraa Hassan on 5/20/19.
//  Copyright © 2019 iti. All rights reserved.
//

import UIKit

class MyLaunchViewController: UIViewController {
    
    //1. Declare ivars
    var appNameLable : UILabel!
    var iconImageView : UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //2. Create the Label and ImageView
        appNameLable = UILabel()
        appNameLable.text = "Movies"
        appNameLable.font = UIFont.systemFont(ofSize: 36)
        appNameLable.textColor = UIColor.red
        appNameLable.sizeToFit()
        appNameLable.center = CGPoint(x: 100 , y: 40)
        view.addSubview(appNameLable)
        
        UIView.animate(withDuration: 0.4, delay: 0.1, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: [] , animations: {
            self.appNameLable.center = CGPoint(x: 100, y: 40 + 200)
        }, completion: nil)
        
        iconImageView = UIImageView()
        iconImageView.image = UIImage(named: "placeholder.png")
        iconImageView.sizeToFit()
        iconImageView.center = CGPoint(x: 200 , y: 90)
        
        view.addSubview(iconImageView)
        self.iconImageView.alpha = 0 // Hidden = 0
        
        UIView.animate(withDuration: 3.0, delay: 0.8, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.0, options: [] , animations: {
            self.iconImageView.center = CGPoint(x: 200, y: 90 + 350)
            self.iconImageView.alpha = 1 // visible = 1
        }, completion: nil)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: {
            
            let sdTab = self.storyboard?.instantiateViewController(withIdentifier: "tabVC") as! UITabBarController
            sdTab.modalPresentationStyle = .overFullScreen
            self.present(sdTab, animated: true, completion: nil)

        })
    }
    override func viewWillDisappear(_ animated: Bool) {
  
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
