//
//  PersonViewModel.swift
//  ssacAuth
//
//  Created by 강호성 on 2021/12/28.
//

import Foundation

class PersonViewModel {
    
    var person: Observable<Person> = Observable(Person(page: 0, results: [], totalPages: 0, totalResults: 0))
    
    func populatePersonAPI(query: String, page: Int) {
        APIService.person(query, page: page) { response, error in
            guard let response = response else { return }
            self.person.value = response
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension PersonViewModel {
    var numberOfRowInSection: Int {
        return person.value.results.count
    }
    
    func cellForRowAt(at indexPath: IndexPath) -> Result {
        return person.value.results[indexPath.row]
    }
}
