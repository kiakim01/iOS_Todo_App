import UIKit

class TodoListPage: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension TodoListPage: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        
        // Find the existing text field in the cell or create a new one
        var textField = cell.viewWithTag(123) as? UITextField
        if textField == nil {
            textField = UITextField(frame: cell.contentView.bounds)
            textField?.placeholder = "Enter text"
            textField?.tag = 123
            textField?.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            cell.contentView.addSubview(textField!)
        }
        
        textField?.text = "\(indexPath.row + 1)"
        
        return cell
    }

    // 사용자 정의 함수: 텍스트를 셀에 업데이트하는 메서드
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
}

