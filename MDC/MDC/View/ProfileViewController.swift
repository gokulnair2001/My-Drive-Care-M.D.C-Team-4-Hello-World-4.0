//
//  ProfileViewController.swift
//  MDC
//
//  Created by Gokul Nair on 03/10/20.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var btn: UIImageView!
    @IBOutlet weak var car1: UIView!
    @IBOutlet weak var car2: UIView!
    @IBOutlet weak var car3: UIView!
    @IBOutlet weak var view2: UIView!
    
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        btn.layer.cornerRadius = 5
        btn.layer.borderWidth = 1
        btn.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        view2.layer.cornerRadius = 30
        
        applyShadow(yourView: car1)
        applyShadow(yourView: car2)
        applyShadow(yourView: car3)
        
        btn1.layer.cornerRadius = 10
        btn2.layer.cornerRadius = 10
        btn3.layer.cornerRadius = 10
        btn4.layer.cornerRadius = 10
      //  applyShadow(yourView: btn1)
        //applyShadow(yourView: btn2)
        //applyShadow(yourView: btn3)
        //applyShadow(yourView: btn4)
    }
    
}

//MARK:- UIView shadow effect

extension ProfileViewController{
    func applyShadow(yourView: UIView){
        yourView.layer.shadowColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        yourView.layer.shadowOpacity = 1
        yourView.layer.shadowOffset = .zero
        yourView.layer.shadowRadius = 3
        yourView.layer.cornerRadius = 30
    }
}
