//
//  ViewController.swift
//  test
//
//  Created by Aminjoni Abdullozoda on 2/21/19.
//  Copyright © 2019 Aminjoni Abdullozoda. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift

class ViewController: UIViewController {
    
    private var tableContainer : UITableView!
    private var dataCollection = ["Dushanbe", "Kulob", "Khudjand"]
    
    //MARK:- UI elements
    let mainVIew : UIView = {
        let view = UIView()
            view.backgroundColor = UIColor(white: 0.6, alpha: 0.4)
            view.layer.cornerRadius = 20
            return view
    }()
    
    let textInputLabel : UITextField = {
        let lbl = UITextField()
            lbl.placeholder = "Add your city"
            lbl.attributedPlaceholder = NSAttributedString(string: "Add your city", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            lbl.autocorrectionType = .no
        
        return lbl
    }()
    
    let btn : UIButton = {
        let b = UIButton()
            b.setTitle("Add", for: .normal)
            b.backgroundColor = UIColor(white: 0.3, alpha: 0.8)
            b.layer.cornerRadius = 20
        b.addTarget(self, action: #selector(ViewController.addNewItem(_:)), for: .touchUpInside)
        
        return b
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
  
        setup()
        setupViews()
        
    }
    
    
    //RX swift
    
    let disposeBag = DisposeBag()
    
    
  
    private func setup(){
        
        //navigation
        view.backgroundColor = .white
        title = "SnapKit Awesome"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        //tableview implementation
        tableContainer = UITableView(frame: .zero, style: .plain)
        tableContainer.layer.cornerRadius = 20
        tableContainer.delegate = self
        tableContainer.dataSource = self
        tableContainer.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
    }
    
    private func setupViews () {
        view.addSubview(mainVIew)
        mainVIew.addSubview(textInputLabel)
        mainVIew.addSubview(tableContainer)
        mainVIew.addSubview(btn)
        
        
        mainVIew.snp.makeConstraints { (make) in
            make.topMargin.left.equalTo(20)
            make.right.bottomMargin.equalTo(-20)
         
        }
        
        textInputLabel.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(mainVIew).inset(15)
            make.height.equalTo(25)
        }
        
        tableContainer.snp.makeConstraints { (make) in
            
            make.top.equalTo(textInputLabel.snp.bottom).offset(10)
            make.bottom.equalTo(btn.snp.top).offset(-10)
            make.left.right.equalTo(mainVIew).inset(5)
        }
        
        btn.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(mainVIew).inset(5)
            make.height.equalTo(50)
        }
        
        
    }
    
    

    @objc func addNewItem (_ sender : Any) {
        
        guard let newItem = textInputLabel.text, !newItem.isEmpty else { return  }
        
        dataCollection.append(newItem)
        tableContainer.reloadData()
        
        textInputLabel.text = nil
    }

}

extension ViewController : UITableViewDelegate,UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataCollection.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = dataCollection[indexPath.row]
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //moving nother
        
        let destinationVC = DetailVC()
            destinationVC.nameCity = dataCollection[indexPath.row]
        self.navigationController?.pushViewController(destinationVC, animated: true)
        
        destinationVC.selectedObser.subscribe(onNext: { (name) in
            
            self.navigationItem.title = name
            
        }).disposed(by: disposeBag)
    }
    
    
    
    
}

