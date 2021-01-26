import UIKit

/*
let point = CGPoint(x: 100, y: 200) // 위치
let size = CGSize(width: 150, height: 190) // 크기

// (100, 200)의 위치에서 150과 190의 크기를 갖는 사각형을 정의한다
let rect = CGRect(origin: point, size: size)
 */

let rect = CGRect(origin: CGPoint(x: 100, y: 200), size: CGSize(width: 150, height: 190))


// frame은 뷰의 위치와 크기를 지정하는 데에 사용되는 속성
let rect2 = CGRect(x: 50, y: 70, width: 90, height: 130)
let view = UIView(frame: rect2)

let view2 = UIView()
view.frame = CGRect(x: 50, y: 70, width: 90, height: 130)

// 뷰 이동 가능
let newPos = CGPoint(x: 70, y: 90)
view.frame.origin = newPos
