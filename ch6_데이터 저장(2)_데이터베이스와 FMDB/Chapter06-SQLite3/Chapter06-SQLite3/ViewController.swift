//
//  ViewController.swift
//  Chapter06-SQLite3
//
//  Created by 윤형찬 on 2021/02/05.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        let dbPath = self.getDBPath()
        self.dbExecute(dbPath: dbPath)
    }
    
    func dbExecute(dbPath: String) {
        // 앱 내 문서 디렉터리 경로에서 SQLite DB 파일을 찾는다.
        var db: OpaquePointer? = nil // SQLite 연결 정보를 담을 객체
        guard sqlite3_open(dbPath, &db) == SQLITE_OK else {
            print("Database Connect Fail")
            return
        }
        
        // 데이터베이스 연결 종료
        defer {
            print("Close Database Connection")
            sqlite3_close(db)
        }
        
        var stmt: OpaquePointer? = nil // 컴파일된 SQL을 담을 객체
        let sql = "CREATE TABLE IF NOT EXISTS sequence (num INTEGER)"
        
        guard sqlite3_prepare(db, sql, -1, &stmt, nil) == SQLITE_OK else {
            print("Prepare Statement Fail")
            return
        }
        
        // stmt 변수 해제
        defer {
            print("Finalize Statement")
            sqlite3_finalize(stmt)
        }
        
        if sqlite3_step(stmt) == SQLITE_DONE {
            print("Create Table Success")
        }
    }
    
    func getDBPath() -> String {
        // 앱 내 문서 디렉터리 경로에서 SQLite DB 파일을 찾는다.
        let fileMgr = FileManager() // 파일 매니저 객체 생성
        let docPathURL = fileMgr.urls(for: .documentDirectory, in: .userDomainMask).first! // 생성된 매니저 객체를 사용하여 앱내의 문서 디렉터리 경로를 찾고, 이를 URL 객체로 생성
        let dbPath = docPathURL.appendingPathComponent("Practice.sqlite").path // URL객체에 "db.sqlite" 파일 경로를 추가한 SQLite3 데이터베이스 경로를 만들어낸다
        
        // dbPath 경로에 파일이 없다면 앱 번들에 만들어 둔 Practice.sqlite를 가져와 복사한다.
        if fileMgr.fileExists(atPath: dbPath) == false {
            let dbSource = Bundle.main.path(forResource: "Practice", ofType: "sqlite")
            try! fileMgr.copyItem(atPath: dbSource!, toPath: dbPath)
        }
        return dbPath
    }

}

