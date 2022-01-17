//
//  Utility.swift
//  ssacFarm
//
//  Created by 강호성 on 2021/12/30.
//

import UIKit

class Utility {
    
    // MARK: - TextField
    
    static func inputContainerView(textField: UITextField) -> UIView {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.centerY.equalTo(view.snp.centerY)
            make.leading.equalTo(view.snp.leading).offset(8)
            make.trailing.equalTo(view.snp.trailing).inset(8)
        }
        
        let dividerView = UIView()
        dividerView.backgroundColor = .lightGray
        
        view.addSubview(dividerView)
        dividerView.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.bottom)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.height.equalTo(0.75)
        }
        
        return view
    }
    
    static func textField(withPlaceholder placeholder: String) -> UITextField {
        let tf = UITextField()
        tf.textColor = .black
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.attributedPlaceholder = NSAttributedString(string: placeholder,
                                                      attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        return tf
    }
    
    // MARK: - Attributed
    
    static func attributedButton(_ firstPart: String, _ secondPart: String) -> UIButton {
        let button = UIButton(type: .system)
        
        let attributedTitle = NSMutableAttributedString(string: firstPart,
                                                        attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        attributedTitle.append(NSAttributedString(string: secondPart,
                                                  attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.systemGreen]))
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }
    
    static func attributedImageButton(_ image: UIImage, _ secondPart: String) -> UIButton {
        let button = UIButton(type: .system)
        
        let attributedString = NSMutableAttributedString(string: "")
        let imageAttachment = NSTextAttachment()
        
        imageAttachment.image = image
        attributedString.append(NSAttributedString(attachment: imageAttachment))
        attributedString.append(NSAttributedString(string: secondPart, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.black]))
        button.setAttributedTitle(attributedString, for: .normal)
        return button
    }
    
    // MARK: - Date
    
    static func dateFormat(dateString: String) -> String {
        let endIndex: String.Index = dateString.index(dateString.startIndex, offsetBy: 18)
        let dateText = String(dateString[...endIndex])
        let date = dateText.toDate(stringValue: dateText) ?? Date()
        let dateValue = date.toString(dateValue: date)
        return dateValue
    }
}
