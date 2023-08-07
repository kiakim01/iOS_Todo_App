import UIKit

class TableView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // 데이터 소스
    let data = ["Apple", "Banana", "Cherry", "Durian", "Elderberry"]

    // 테이블 뷰
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 테이블 뷰 초기화
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        
        // 테이블 뷰 등록
        view.addSubview(tableView)
    }
    
    // 테이블 뷰 셀 개수 반환
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    // 테이블 뷰 셀 설정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    
    // 테이블 뷰 셀 선택 처리
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 선택된 셀의 항목 출력
        print("선택된 항목: \(data[indexPath.row])")
    }
}
