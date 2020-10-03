//
//  HomeViewController.swift
//  MDC
//
//  Created by Gokul Nair on 03/10/20.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var infoBtn: UIButton!
    @IBOutlet weak var servicebutton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func infoBtn(_ sender: Any) {
        buttonAnimation(button:infoBtn )
    }
    
    @IBAction func serviceBtn(_ sender: Any) {
        buttonAnimation(button: servicebutton)
    }
    
}

//MARK:- UI Method

extension HomeViewController
{
    func buttonAnimation(button: UIButton){
        UIView.animate(withDuration: 0.6,
        animations: { button.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        },
        completion: { _ in
        UIView.animate(withDuration: 0.6) {button.transform = CGAffineTransform.identity
        }
    })
  }
}
