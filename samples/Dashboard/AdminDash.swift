//
//  AdminDash.swift
//  samples
//
//  Created by Gilang Pratama Priadi on 11/12/20.
//

import SwiftUI

struct AdminDash: View {
    @State var levels: [sessionData] = []
    @State var nama: String = ""
    
    var body: some View {
        Text("YAHALOOO!")
        Text(nama)
            .bold()
            .onAppear {
                fetchLevel().getLevel(Authorization: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzZXNzaW9ucyI6eyJpZCI6MSwibGV2ZWwiOjEsIm5hbWEiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImlhdCI6MTYwNzY5NjU1N30sImlhdCI6MTYwNzY5NjYwMSwiZXhwIjoxNjA3NzgzMDAxfQ.b0EL8r-HjULVyHJ6H-rsNmPVlm8SW3qNGMsZafCF8b8") { (levels) in
                    self.levels = levels
                    self.nama = levels[0].nama
                }
            }
    }
}

struct AdminDash_Previews: PreviewProvider {
    static var previews: some View {
        AdminDash()
    }
}
