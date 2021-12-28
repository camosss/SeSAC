//
//  LottoViewModel.swift
//  ssacAuth
//
//  Created by 강호성 on 2021/12/28.
//

import Foundation

class LottoViewModel {
    
    var lotto1 = Observable(1)
    var lotto2 = Observable(2)
    var lotto3 = Observable(3)
    var lotto4 = Observable(4)
    var lotto5 = Observable(5)
    var lotto6 = Observable(6)
    var lotto7 = Observable(7)
    
    var lottoMoney: Observable<String> = Observable("")
    
    func populateLottoAPI(_ number: Int) {
        APIService.lotto(number) { lotto, error in
            
            guard let lotto = lotto else { return }

            self.lotto1.value = lotto.drwtNo1
            self.lotto2.value = lotto.drwtNo2
            self.lotto3.value = lotto.drwtNo3
            self.lotto4.value = lotto.drwtNo4
            self.lotto5.value = lotto.drwtNo5
            self.lotto6.value = lotto.drwtNo6
            self.lotto7.value = lotto.bnusNo
            
            self.lottoMoney.value = self.format(for: lotto.firstWinamnt)
        }
    }
    
    private func format(for number: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        let result = numberFormatter.string(for: number)!
        return result
    }
}
