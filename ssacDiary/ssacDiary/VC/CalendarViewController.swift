//
//  CalendarViewController.swift
//  ssacDiary
//
//  Created by 강호성 on 2021/11/01.
//

import UIKit
import FSCalendar
import RealmSwift

class CalendarViewController: UIViewController {

    // MARK: - Properties

    @IBOutlet weak var calendarView: FSCalendar!
    
    let localRealm = try! Realm()
    
    var tasks: Results<UserDiary>!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = LocalizableStrings.calendar.localized
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont().mainDemiBold]

        calendarView.delegate = self
        calendarView.dataSource = self
        
        tasks = localRealm.objects(UserDiary.self)
        
//        let allCnt = getAllDiaryCountFromUserDiary()
//        label.text = "총 \(allCnt)개"
        
//        let recent = localRealm.objects(UserDiary.self).sorted(byKeyPath: "createdDate", ascending: false).first?.diaryTitle
//
//        let full = localRealm.objects(UserDiary.self).filter("content != nil").count
//
//        let favorite = localRealm.objects(UserDiary.self).filter("favorite = false")
        
    }
}

// MARK: - FSCalendarDataSource, FSCalendarDelegate

extension CalendarViewController: FSCalendarDataSource, FSCalendarDelegate {
   
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        return tasks.filter("createdDate == %@", date).count
    }
}
