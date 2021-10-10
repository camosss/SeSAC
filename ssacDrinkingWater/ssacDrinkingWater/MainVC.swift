//
//  MainVC.swift
//  ssacDrinkingWater
//
//  Created by 강호성 on 2021/10/08.
//

import UIKit

class MainVC: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var totalToday: UILabel!
    @IBOutlet weak var todayGoal: UILabel!
    @IBOutlet weak var intakeLabel: UILabel!
    
    @IBOutlet weak var addValueTextField: UITextField!
    @IBOutlet weak var drinkButton: UIButton!
    @IBOutlet weak var currentLevelImage: UIImageView!
    
    let userDefaults = UserDefaults.standard
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchData()
    }
    
    // MARK: - Helper
    
    func configureUI() {
        titleLabel.text = "잘하셨어요!\n오늘 마신 양은"
        
        drinkButton.clipsToBounds = true
        drinkButton.layer.cornerRadius = 10
        drinkButton.layer.borderColor = UIColor.lightGray.cgColor
        drinkButton.layer.borderWidth = 1
    }
    
    func fetchData() {
        let totalNum = userDefaults.integer(forKey: "totalML") // 6. 저장되어있는 값 가져와서 view가 로드될 때, text에 값 띄우기
        totalToday.text = "\(totalNum)ml"
        
        let nickname = userDefaults.string(forKey: "name")
        let recommend = userDefaults.double(forKey: "recommend")
        intakeLabel.text = "\(nickname ?? "")님의 하루 물 권장 섭취량은 \(recommend)L 입니다."
        
        let goal = userDefaults.integer(forKey: "goal")
        if goal < 100 {
            todayGoal.text = "목표의 \(Int(goal))%"
            todayGoal.textColor = .white
        } else {
            todayGoal.text = "목표의 \(Int(goal))%"
            todayGoal.textColor = .red
        }
        
        changeImage(goal)
    }
    
    fileprivate func changeImage(_ goal: Int) {
        // 이미지 변경
        switch goal {
        case 0..<20:
            currentLevelImage.image = UIImage(named: "1-1")
        case 20..<30:
            currentLevelImage.image = UIImage(named: "1-2")
        case 30..<40:
            currentLevelImage.image = UIImage(named: "1-3")
        case 40..<50:
            currentLevelImage.image = UIImage(named: "1-4")
        case 50..<60:
            currentLevelImage.image = UIImage(named: "1-5")
        case 60..<70:
            currentLevelImage.image = UIImage(named: "1-6")
        case 70..<80:
            currentLevelImage.image = UIImage(named: "1-7")
        case 80..<90:
            currentLevelImage.image = UIImage(named: "1-8")
        case 90...100:
            currentLevelImage.image = UIImage(named: "1-9")
        default:
            currentLevelImage.image = UIImage(named: "1-9")
        }
    }
    
    // MARK: - Action
    
    @IBAction func refreshButton(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "초기화 하시겠어요?", message: nil, preferredStyle: .alert)
        
        let OK = UIAlertAction(title: "OK", style: .default, handler: {_ in
            self.userDefaults.set(0, forKey: "totalML") // (1) 데이터를 0으로 저장
            let resetNum = self.userDefaults.integer(forKey: "totalML") // (2) 값을 가져와서
            self.totalToday.text = "\(resetNum)ml" // (3) totalToday 값에 reset값 넣기
            
            self.userDefaults.set(0, forKey: "goal")
            self.todayGoal.text = "목표의 0%"
            self.todayGoal.textColor = .white
        })
        
        let NO = UIAlertAction(title: "NO", style: .destructive, handler: nil)
        
        alert.addAction(OK)
        alert.addAction(NO)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func addValueButton(_ sender: UIButton) {
        
        if let addValue = addValueTextField.text {
            let intAddValue = Int(addValue) ?? 0 // 1. textField의 string값 -> Int로 형변환
            
            let totalNum = userDefaults.integer(forKey: "totalML") // 2. 현재 키값에 저장되어있는 값 가져오기
            userDefaults.set(totalNum + intAddValue, forKey: "totalML") // 3. 그 값에 + textField 값 저장
            
            let updateNum = userDefaults.integer(forKey: "totalML") // 4. + textField 값 가져오기
            totalToday.text = "\(updateNum)ml" // 5. totalToday 값에 update값 넣기
            
            let recommend = userDefaults.double(forKey: "recommend")
            let goal = Double(totalNum) / Double(recommend) / 10

            userDefaults.set(goal, forKey: "goal")
            
            if goal < 100 {
                todayGoal.text = "목표의 \(Int(goal))%"
                todayGoal.textColor = .white
            } else {
                todayGoal.text = "목표의 \(Int(goal))%"
                todayGoal.textColor = .red
            }
            
            changeImage(Int(goal))
        }
    }
    
    
    // unwind segue
    @IBAction func backButton(_ sender: UIStoryboardSegue) {
        
        if let vc = sender.source as? ProfileVC {
            if let height = vc.heightTextField.text, let weight = vc.weightTextField.text {
                let intHeight = Double(height) ?? 1, intWeight = Double(weight) ?? 1
                let nickName = vc.nameTextField.text ?? ""
                
                let recommend = (intHeight + intWeight) / 100
                let totalNum = userDefaults.integer(forKey: "totalML")
                let goal = Double(totalNum) / Double(recommend) / 10
                
                intakeLabel.text = "\(nickName)님의 하루 물 권장 섭취량은 \(recommend)L 입니다."
                todayGoal.text = "목표의 \(Int(goal))%"
                
                userDefaults.set(nickName, forKey: "name")
                userDefaults.set(recommend, forKey: "recommend")
                userDefaults.set(Int(goal), forKey: "goal")
                
            }
        }
    }
    
}

