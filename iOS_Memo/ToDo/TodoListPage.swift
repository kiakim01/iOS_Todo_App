import UIKit

class TodoListPage: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 뷰 컨트롤러 초기화 작업 수행
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension TodoListPage: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 실제 데이터의 행 수 반환
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        
        cell.textLabel?.text = "\(indexPath.row + 1)"
        
        return cell
    }
    //New
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 셀이 선택되었을 때 호출되는 메서드
        showTextAlert(for: indexPath)
    }
    
    // 사용자 정의 함수: 텍스트 입력을 받는 알림창을 표시하는 메서드
    func showTextAlert(for indexPath: IndexPath) {
        let alertController = UIAlertController(title: "텍스트 입력", message: "원하는 텍스트를 입력하세요.", preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "텍스트 입력"
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        let saveAction = UIAlertAction(title: "저장", style: .default) { [weak self, weak alertController] _ in
            guard let textField = alertController?.textFields?.first,
                  let newText = textField.text else {
                return
            }
            // 입력받은 텍스트를 셀에 적용
            self?.updateText(newText, for: indexPath)
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    // 사용자 정의 함수: 텍스트를 셀에 업데이트하는 메서드
    func updateText(_ newText: String, for indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else {
            return
        }
        cell.textLabel?.text = newText
    }
}


