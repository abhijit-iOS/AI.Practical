//
//  ViewController.swift
//  Practical
//
//  Created by MAC100 on 12/30/19.
//  Copyright © 2019 MAC100. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK:- IBOutlet
    @IBOutlet private weak var clnUsers: UICollectionView!
    
    // MARK:- Varaibles
    private var arrUsers = [User]()
    private var nextOffset = 0
    
    // MARK:- View Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        prepareView()
    }
    // MARK:- Custom Methods
    private func prepareView()  {
        clnUsers.register(UINib(nibName: String(describing: ItemsCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: ItemsCell.self))
        clnUsers.register(UINib(nibName: String(describing: UserHeaderCell.self), bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: UserHeaderCell.self))
    }
    
    // MARK:- Web service Methods
    private func getUserList() {
        
        WebService.sendRequest(.getUserList, query: "offset=\(self.nextOffset)&limit=\(pageLimit)") { (result) in
            switch result {
            case .success(let response):
                if response.status {
                    if let data = response.data as? [User] {
                        if self.nextOffset == 0 {
                            self.arrUsers.removeAll()
                        }
                        self.arrUsers.append(contentsOf: data)
                        DispatchQueue.main.async {
                            self.clnUsers.reloadData()
                        }
                    }
                } else {
                    
                }
                break
            case .failure(let error):
                break
            }
        }
    }
}

extension ViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.arrUsers.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrUsers[section].items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ItemsCell.self), for: indexPath)
        
        return cell
    }
    
    
}
