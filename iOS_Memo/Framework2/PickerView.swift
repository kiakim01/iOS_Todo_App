//
//  PickerView.swift
//  iOS_Memo
//
//  Created by kiakim on 2023/08/02.
//

import UIKit


//🔥 console에 입력값이 출력되지 않는문제
class PickerView: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    let pickerView = UIPickerView()
    var data = ["항목1", "항목2", "항목3"]

    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.frame = CGRect(x: 100, y: 100, width: 200, height: 200)
        self.view.addSubview(pickerView)
        pickerView.dataSource = self
        pickerView.delegate = self
    }

    // 데이터 소스 메서드
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }

    // 델리게이트 메서드
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedValue = data[row]
        // 선택된 값을 사용
        print("선택한 값", selectedValue)
    }
}
