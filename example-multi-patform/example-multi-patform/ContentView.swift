//
//  ContentView.swift
//  example-multi-patform
//
//  Created by Chandan on 19/07/25.
//

import SwiftUI
import SQLCipher

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }

    func test() {
        print("ArticleService init")
        print("Linked SQLite version: \(String(cString: sqlite3_libversion()))")

        var rc: Int32
        var db: OpaquePointer? = nil
        var stmt: OpaquePointer? = nil
        let password: String = "correct horse battery staple"
        rc = sqlite3_open(":memory:", &db)
        if (rc != SQLITE_OK) {
            let errmsg = String(cString: sqlite3_errmsg(db))
            NSLog("Error opening database: \(errmsg)")
            return
        }
        rc = sqlite3_key(db, password, Int32(password.utf8CString.count))
        if (rc != SQLITE_OK) {
            let errmsg = String(cString: sqlite3_errmsg(db))
            NSLog("Error setting key: \(errmsg)")
        }

        // When using Commercial or Enterprise packages you must call PRAGMA cipher_license with a valid License Code.
        // Failure to provide a license code will result in an SQLITE_AUTH(23) error.
        // Trial licenses are available at https://www.zetetic.net/sqlcipher/trial/
        let licensePragma = ("PRAGMA cipher_license = 'ENTER_LICENSE_KEY_HERE';" as NSString).utf8String
        rc = sqlite3_exec(db, licensePragma, nil, nil, nil)
        if (rc != SQLITE_OK) {
            let errmsg = String(cString: sqlite3_errmsg(db))
            NSLog("Error with cipher_license: \(errmsg)")
        }
        rc = sqlite3_prepare(db, "PRAGMA cipher_version;", -1, &stmt, nil)
        if (rc != SQLITE_OK) {
            let errmsg = String(cString: sqlite3_errmsg(db))
            NSLog("Error preparing SQL: \(errmsg)")
        }
        rc = sqlite3_step(stmt)
        if (rc == SQLITE_ROW) {
            NSLog("cipher_version: %s", sqlite3_column_text(stmt, 0))
        } else {
            let errmsg = String(cString: sqlite3_errmsg(db))
            NSLog("Error retrieiving cipher_version: \(errmsg)")
        }
        sqlite3_finalize(stmt)
        sqlite3_close(db)
    }
}

#Preview {
    ContentView()
}
