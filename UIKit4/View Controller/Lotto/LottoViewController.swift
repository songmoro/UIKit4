//
//  LottoViewController.swift
//  UIKit4
//
//  Created by 송재훈 on 7/24/25.
//

import UIKit
import Alamofire
import SnapKit

class LottoViewController: UIViewController {
    let resultLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        request()
    }
    
    func configure() {
        view.backgroundColor = .systemBackground
        view.addSubview(resultLabel)
        
        resultLabel.text = "Label"
        
        resultLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
    func request() {
        let url = URL(string: "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=1181")!

        AF.request(url, method: .get)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: Lotto.self) { [self] response in
                switch response.result {
                case .success(let lotto):
                    resultLabel.text = String(describing: lotto)
                case .failure:
                    resultLabel.text = "데이터 로드 실패"
                }
            }
    }
}

#Preview {
    LottoViewController()
}
