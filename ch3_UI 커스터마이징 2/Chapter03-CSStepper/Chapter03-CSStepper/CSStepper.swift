//
//  CSStepper.swift
//  Chapter03-CSStepper
//
//  Created by 윤형찬 on 2021/01/28.
//

import UIKit

@IBDesignable
public class CSStepper: UIControl {
    
    public var leftBtn = UIButton(type: .system) // 좌측 버튼
    public var rightBtn = UIButton(type: .system) // 우측 버튼
    public var centerLabel = UILabel() // 중앙 레이블
    
    @IBInspectable
    public var value: Int = 0 { // 스테퍼의 현재값을 저장할 변수
        didSet { // 프로퍼티의 값이 바뀌면 자동으로 호출된다.
            self.centerLabel.text = String(value)
            
            // 이 클래스를 사용하는 객체들에게 valueChanged 이벤트 신호를 보내준다.
            self.sendActions(for: .valueChanged)
        }
    }
    
    // 좌측 버튼의 타이틀 속성
    @IBInspectable
    public var leftTitle: String = "⬇︎" {
        didSet {
            self.leftBtn.setTitle(leftTitle, for: .normal)
        }
    }
    
    // 우측 버튼의 타이틀
    @IBInspectable
    public var rightTitle: String = "⬆︎" {
        didSet {
            self.rightBtn.setTitle(rightTitle, for: .normal)
        }
    }
    
    // 센터 영역의 색상
    @IBInspectable
    public var bgColor: UIColor = UIColor.cyan {
        didSet {
            self.centerLabel.backgroundColor = backgroundColor
        }
    }
    
    // 증감값 단위
    @IBInspectable
    public var stepValue: Int = 1
    
    // 최대값과 최소값
    @IBInspectable public var maximumValue: Int = 100
    @IBInspectable public var minimumValue: Int = -100
    
    // 스토리보드에서 호출할 초기화 메소드
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    // 프로그래밍 방식으로 호출할 초기화 메소드
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    private func setup() {
        
        let borderWidth: CGFloat = 0.5 // 테두리 두께값
        let borderColor = UIColor.blue.cgColor // 테두리 색상값
        
        // 좌측 다운 버튼 속성 설정
        self.leftBtn.tag = -1 // 태그값에 -1을 부여
        self.leftBtn.setTitle(self.leftTitle, for: .normal) // 버튼의 타이틀
        self.leftBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        
        // 버튼 타이틀의 폰트
        self.leftBtn.layer.borderWidth = borderWidth // 버튼 테두리 두께
        self.leftBtn.layer.borderColor = borderColor // 버튼 테두리 색상 - 파란색
        
        // 우측 업 버튼 속성 설정
        self.rightBtn.tag = 1 // 태그값에 1을 부여
        self.rightBtn.setTitle(self.rightTitle, for: .normal) // 버튼의 타이틀
        self.rightBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        
        // 버튼 타이틀의 폰트
        self.rightBtn.layer.borderWidth = borderWidth // 버튼 테두리 두께
        self.rightBtn.layer.borderColor = borderColor // 버튼 테두리 색상 - 파란색
        
        // 중앙 레이블 속성 설정
        self.centerLabel.text = String(value) // 컨트롤의 현재값을 문자열로 변환하여 표시
        self.centerLabel.font = UIFont.systemFont(ofSize: 16) // 레이블의 폰트
        self.centerLabel.textAlignment = .center // 가운데 정렬
        self.centerLabel.backgroundColor = self.bgColor // 배경 색상 지정
        self.centerLabel.layer.borderWidth = borderWidth // 레이블의 테두리 두께
        self.centerLabel.layer.borderColor = borderColor // 레이블의 테두리 색상 - 파란색
        
        // 영역별 객체를 서브 뷰로 추가한다.
        self.addSubview(self.leftBtn)
        self.addSubview(self.rightBtn)
        self.addSubview(self.centerLabel)
        
        // 버튼의 터치 이벤트와 valueChange(_:) 메소드를 연결한다.
        self.leftBtn.addTarget(self, action: #selector(valueChange(_:)), for: .touchUpInside)
        self.rightBtn.addTarget(self, action: #selector(valueChange(_:)), for: .touchUpInside)
    }
    
    // value 속성의 값을 변경하는 메소드
    @objc public func valueChange(_ sender: UIButton) {
        // 스테퍼의 값을 변경하기 전에, 미리 최소값과 최대값 범위를 벗어나지 않는지 체크한다.
        let sum = self.value + (sender.tag * self.stepValue)
        
        // 더한 결과가 최대값보다 크면 값을 변경하지 않고 종료
        if sum > self.maximumValue {
            return
        }
        // 더한 결과가 최소값보다 작으면 값을 변경하지 않고 종료
        if sum < self.minimumValue {
            return
        }
        
        // 현재의 value 값에 +1 또는 -1한다.
        self.value += (sender.tag * self.stepValue)
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        // 버튼의 너비 = 뷰 높이
        let btnWidth = self.frame.height
        
        // 레이블의 너비 = 뷰 전체 크기 - 양쪽 버튼의 너비 합
        let lblWidth = self.frame.width - (btnWidth * 2)
        
        self.leftBtn.frame = CGRect(x: 0, y: 0, width: btnWidth, height: btnWidth)
        self.centerLabel.frame = CGRect(x: btnWidth, y: 0, width: lblWidth, height: btnWidth)
        self.rightBtn.frame = CGRect(x: btnWidth+lblWidth, y: 0, width: btnWidth, height: btnWidth)
    }
}
