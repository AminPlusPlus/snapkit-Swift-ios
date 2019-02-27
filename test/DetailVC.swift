//
//  DetailVC.swift
//  test
//
//  Created by Aminjoni Abdullozoda on 2/22/19.
//  Copyright © 2019 Aminjoni Abdullozoda. All rights reserved.
//

import UIKit
import SpriteKit
import RxSwift


class DetailVC: UIViewController
{
    
    var nameCity : String?
    
    //MARK:-  UI ELEMENTS
    private let welcomeTitle : UILabel = {
        let lbl = UILabel()
            lbl.font = UIFont(name: "Arial", size: 25)
            lbl.textColor  = .black
        return lbl
    }()
    
    private let btn : UIButton = {
        let b = UIButton()
            b.setTitle("Select ME", for: .normal)
            b.addTarget(self, action: #selector(selectedBtn(_:)), for: .touchUpInside)
            b.backgroundColor = .blue
            b.layer.cornerRadius = 10
        return b
    }()
    
    
    //RXswift
    private var selecatedValue = Variable("")
    var selectedObser : Observable<String> {
        return selecatedValue.asObservable()
    }
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = .white
        self.navigationItem.title = nameCity
        
        setupViews()
        
        welcomeTitle.text = nameCity
    }
    
    private func setupViews(){
        
        view.addSubview(welcomeTitle)
        view.addSubview(btn)
        
        welcomeTitle.snp.makeConstraints { (make) in
            make.centerX.centerY.equalTo(view)
        }
        
        btn.snp.makeConstraints { (make) in
            make.top.equalTo(welcomeTitle.snp.bottom).offset(10)
            make.centerX.equalTo(welcomeTitle)
            
            make.trailingMargin.leadingMargin.equalTo(view)
            make.height.equalTo(40)
        }
    }
    
    @objc private func selectedBtn (_ sender : UIButton) {
        print("selected")
        
        selecatedValue.value = nameCity!
        
        navigationController?.popViewController(animated: true)
    }
    

}
