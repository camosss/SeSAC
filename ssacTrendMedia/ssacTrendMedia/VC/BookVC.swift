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
        
        let nibName = UINib(nibName: BookCell.identifier, bundle: nil)
        collectionView.register(nibName, forCellWithReuseIdentifier: BookCell.identifier)
        
        configureLayout()
    }
    
    // MARK: - Helper
    
    func configureLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing * 2, bottom: spacing, right: spacing * 2)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.scrollDirection = .vertical
        collectionView.collectionViewLayout = layout
    }
    
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension BookVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookInfo.tvShow.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCell.identifier, for: indexPath) as? BookCell else { return UICollectionViewCell() }
        
        let bookInfo = bookInfo.tvShow[indexPath.item]
        let colorList = [#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1), #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), #colorLiteral(red: 0.9764705896, green: 0.8539345136, blue: 0.4624189993, alpha: 1), #colorLiteral(red: 0.8753982546, green: 0.2942236511, blue: 0.9764705896, alpha: 1), #colorLiteral(red: 0.7724966407, green: 0.8129963875, blue: 1, alpha: 1), #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1), #colorLiteral(red: 0.9764705896, green: 0.2338845934, blue: 0.4620435073, alpha: 1), #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)]

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
}
