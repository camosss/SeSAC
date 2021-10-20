//
//  BookVC.swift
//  ssacTrendMedia
//
//  Created by 강호성 on 2021/10/19.
//

import UIKit

class BookVC: UIViewController {
    
    // MARK: - Properties
    
    let bookInfo = TvShowInfo()
    let spacing: CGFloat = 10

    @IBOutlet weak var collectionView: UICollectionView!

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "책"
        
        let nibName = UINib(nibName: BookCell.identifier, bundle: nil)
        collectionView.register(nibName, forCellWithReuseIdentifier: BookCell.identifier)
        
        configureLayout()
    }
    
    // MARK: - Helper
    
    func configureLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        collectionView.collectionViewLayout = layout
    }
    
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension BookVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookInfo.tvShow.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCell.identifier, for: indexPath) as! BookCell
        
        let bookInfo = bookInfo.tvShow[indexPath.item]
        let colorList = [#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1), #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1), #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)]

        cell.titleLabel.text = bookInfo.title
        cell.rateLabel.text = "\(bookInfo.rate)"
        cell.postImageView.setImage(imageUrl: bookInfo.backdropImage)
        cell.backgroundColor = colorList.randomElement()
        cell.layer.cornerRadius = 10
        
        cell.layer.cornerRadius = 10
        cell.layer.shadowOpacity = 0.5
        cell.layer.shadowRadius = 10
        cell.layer.shadowOffset = .init(width: 0, height: -5)
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension BookVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width - (spacing * 5)
        return CGSize(width: width/2, height: width/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: spacing, left: spacing * 2, bottom: spacing, right: spacing * 2)
    }
    
}
