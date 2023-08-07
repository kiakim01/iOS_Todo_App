//
//  ScrollView.swift
//  iOS_Memo
//
//  Created by kiakim on 2023/08/02.
//

import UIKit


//🔥 Zoom-in, Zoom-out이 안되는 문제
class ScrollView: UIViewController, UIScrollViewDelegate {
    
    //강제 언래핑을 사용하는 이유가 있을까 ?
    var scrollView: UIScrollView!
    var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //스크롤뷰 > 스택뷰 > 이미지뷰
        
        // 스크롤 뷰 생성
        scrollView = UIScrollView(frame: CGRect(origin: CGPoint(x:0,y:300), size: CGSize(width: view.bounds.width, height: 200)))
        scrollView.delegate = self
        scrollView.backgroundColor   = UIColor.lightGray
        scrollView.layer.borderWidth = 2.0
        scrollView.layer.borderColor = UIColor.black.cgColor
        scrollView.layer.cornerRadius = 10.0
        // 뷰에 스크롤 뷰 추가
        view.addSubview(scrollView)
        
        
        // 이미지 뷰 생성
        
        let image = UIImage(systemName: "paperclip.badge.ellipsis")
        imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
//        imageView.frame = CGRect(origin: CGPoint.init(x: 100, y: 100), size: CGSize(width: 100, height: 100))
//
        imageView.frame = CGRect(origin: CGPoint(x: (scrollView.bounds.width - 100) / 2, y: (scrollView.bounds.height - 100) / 2), size: CGSize(width: 100, height: 100)) // NEW
       
        
                
        
     
        // 이미지 뷰를 스크롤 뷰에 추가
        scrollView.addSubview(imageView)
        
        // 스크롤 뷰 설정
        scrollView.contentSize = CGSize(width: view.bounds.width * 2, height: 400)
        scrollView.minimumZoomScale = 0.5
        scrollView.maximumZoomScale = 2.0
        
     
    }
    
    // UIScrollViewDelegate 메서드 구현
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
