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
        
        //UI에 토글 스위치 추가
        let toggle = UISwitch()
        toggle.isOn = switchStates[indexPath] ?? false
        toggle.onTintColor = .blue
        toggle.addTarget(self, action: #selector(switchDidChange(_:)), for: .valueChanged)
        
  // UISwitch의 위치를 계산합니다.
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
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text,
              let row = textField.tag as Int? else {
            return
        }
        updateText(text, for: IndexPath(row: row, section: 0))
    }
    
   // 토글 액션추가
    @objc func switchDidChange(_ toggleSwitch: UISwitch) {
        print("Toggle state changed: \(toggleSwitch.isOn)")
    }
}

