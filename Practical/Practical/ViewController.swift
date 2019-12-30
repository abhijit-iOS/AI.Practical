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
    private var hasNextPage = false
    private var isLoading = false
    
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
        clnUsers.register(UINib(nibName: String(describing: UserFooterCell.self), bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: String(describing: UserFooterCell.self))
        getUserList()
    }
    
    // MARK:- Web service Methods
    private func getUserList() {
        isLoading = true
        WebService.sendRequest(.getUserList, query: "offset=\(self.nextOffset)&limit=\(pageLimit)") { (result) in
            switch result {
            case .success(let response):
                self.hasNextPage = response.hasNextPage
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
            self.isLoading = false
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ItemsCell.self), for: indexPath) as! ItemsCell
        cell.item = self.arrUsers[indexPath.section].items[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: UserHeaderCell.self), for: indexPath) as! UserHeaderCell
            header.user = arrUsers[indexPath.section]
            return header
        case UICollectionView.elementKindSectionFooter:
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: UserFooterCell.self), for: indexPath) as! UserFooterCell
            footer.startLoading()
            return footer
        default:
            return UICollectionReusableView()
        }
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (indexPath.section == self.arrUsers.count - 1) && (indexPath.row == self.arrUsers[indexPath.section].items.count - 1) && hasNextPage && !isLoading {
            self.nextOffset += 10
            self.getUserList()
        }
    }
}

extension ViewController : UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsCount  = arrUsers[indexPath.section].items.count
        let clnWidth:CGFloat = collectionView.frame.size.width
        let spacing:CGFloat = 10
        let width = (clnWidth - (spacing*3))/2.0
        if itemsCount % 2 == 0 {
            return CGSize(width: width, height: width)
        } else {
            if indexPath.row == 0 {
                return CGSize(width: clnWidth - (spacing*2), height: clnWidth - (spacing*2))
            } else {
                return CGSize(width: width, height: width)
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 70.0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        let height:CGFloat = ((section == arrUsers.count - 1) && hasNextPage) ? 70.0 : 0.7
        return CGSize(width: collectionView.frame.size.width, height: height)
    }
    
}
