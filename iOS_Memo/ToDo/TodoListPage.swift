import UIKit

class TodoListPage: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var numberOfItems = 2 // 초기 행 개수
    var switchStates: [IndexPath: Bool] = [:] // 각 셀의 UISwitch 상태를 저장하는 딕셔너리

    
    @IBAction func TodoButton(_ sender: UIButton) {
        // TodoButton에 대한 액션 구현
    }
    
    @IBAction func CompleteButton(_ sender: UIButton) {
        // CompleteButton에 대한 액션 구현
    }
    
    @IBAction func AddButton(_ sender: UIButton) {
        numberOfItems += 1
        tableView.reloadData()
    }
        

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        


    }
}

extension TodoListPage: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfItems
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        
        var textField = cell.viewWithTag(123) as? UITextField
        if textField == nil {
            textField = UITextField(frame: CGRect(x: 0, y: 0, width: cell.contentView.bounds.width - 80, height: cell.contentView.bounds.height))
            textField?.placeholder = "텍스트 입력"
            textField?.tag = 123
            textField?.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            cell.contentView.addSubview(textField!)
        }
        
//        //UI에 토글 스위치 추가
        let toggle = UISwitch()
        toggle.isOn = switchStates[indexPath] ?? true
        toggle.onTintColor = .blue
        toggle.addTarget(self, action: #selector(switchDidChange(_:)), for: .valueChanged)

        toggle.frame.origin = CGPoint(x: cell.contentView.bounds.width - toggle.bounds.width - 8, y: (cell.contentView.bounds.height - toggle.bounds.height) / 2)
        cell.contentView.addSubview(toggle)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func updateText(_ newText: String, for indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.textLabel?.text = newText
        }
    }
    
//    // 뒤로 밀어서 스와이프 동작 (오른쪽에서 왼쪽으로)
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

//    }

    // 앞으로 밀어서 스와이프 동작 (왼쪽에서 오른쪽으로)
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // 필요한 경우 앞으로 밀어서 스와이프 동작을 생성하고 구성합니다
        
        let completeAction = UIContextualAction(style: .destructive, title: "완료") { [weak self] (action, view, completionHandler) in
            guard self != nil else { return }
                
           completionHandler(true)
            }
        completeAction.backgroundColor = UIColor.blue
        
        let deleteAction = UIContextualAction(style: .destructive, title: "삭제") { [weak self] (action, view, completionHandler) in
                guard let self = self else { return }
                
                // 데이터 소스에서 해당 아이템을 삭제하고 테이블 뷰를 업데이트합니다
                self.switchStates.removeValue(forKey: indexPath) // 필요한 경우에만
                self.numberOfItems -= 1 // 필요한 경우에만
            self.tableView.deleteRows(at: [indexPath], with: .fade)
                
                // 삭제 동작을 완료합니다
                completionHandler(true)
            }
        
        let configuration = UISwipeActionsConfiguration(actions: [completeAction, deleteAction])
           configuration.performsFirstActionWithFullSwipe = false // 부분적으로 스와이프할 때 두 동작을 모두 표시합니다
           
           return configuration


    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text,
              let row = textField.tag as Int? else {
            return
        }
        updateText(text, for: IndexPath(row: row, section: 0))
    }
    
   // 토글 액션추가

    @objc func switchDidChange(_ sender: UISwitch) {
        let isSwitchOn = sender.isOn

        if let cell = sender.superview?.superview as? UITableViewCell,
           let _ = tableView.indexPath(for: cell),
           let textField = cell.viewWithTag(123) as? UITextField {
            
            if !isSwitchOn {
                // Apply strike-through effect to the text in the UITextField
                let attributedText = NSAttributedString(string: textField.text ?? "", attributes: [
                    NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue,
                    NSAttributedString.Key.strikethroughColor: UIColor.black
                ])
                textField.attributedText = attributedText
            } else {
                let attributedText = NSAttributedString(string: textField.text ?? "")
                textField.attributedText = attributedText
            }
        }
    }


}


