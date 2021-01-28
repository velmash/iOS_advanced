class Boo {
    var v: Int = 0
    var c: String = ""
}

class BooEx: Boo {
    var d: Int
    
    override init() {
        self.d = 0
        super.init()
    }
}


class A {
    var a = 0
    
    init(v: Int) {
    }
    
    convenience init(m: Int) {
        self.init(v: m)
    }
}

class B: A {
    var b = 0
    
    convenience init(f: Int) {
        self.init(v: f)
    }
}

let a1 = A(v: 0)
let b1 = B(f: 0) // 정의한 편의 초기화 메소드
let b2 = B(v: 0) // 상속된 지정 초기화 메소드
let b3 = B(m: 0) // 상속된 편의 초기화 메소드


