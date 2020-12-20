//
//  PortalLoginView.swift
//  samples
//
//  Created by Gilang Pratama Priadi on 11/12/20.
//

import SwiftUI

struct PortalLoginView: View {
    @State var loggedIn = false
    @State var emptyValue = false
    @State var tokens: [Token] = []
    @State var username: String = ""
    @State var password: String = ""
    
    var body: some View {
        if loggedIn {
            AdminDash()
        } else {
            VStack(content: {
                HStack(content: {
                    Text("PORTAL")
                    Text("LOGIN").fontWeight(.heavy)
                }).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                
                VStack(content: {
                    Text("SAMPLE APP").font(.caption)
                })
                
                Spacer()
                
                VStack(content: {
                    TextField(
                        "User name (email address)",
                         text: $username
                    )
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .border(Color(UIColor.separator))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                })
                
                VStack(content: {
                    SecureField(
                        "Password",
                         text: $password
                    )
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                })
                
                HStack(content: {
                    Button("Sign In", action: signIn).accentColor(.gray)
                        .alert(isPresented: $emptyValue) {
                            Alert(
                                title: Text("Data kosong!"),
                                message: Text("Tolong sertakan username dan password."),
                                dismissButton: .default(Text("Ok!"))
                            )
                        }
                })
                .padding(5.0)
                .border(Color.gray, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                .buttonStyle(BorderlessButtonStyle())
                
                Spacer()
                
                Spacer()
                
                HStack(content: {
                    Text("2020 © Company").font(.footnote)
                })
            })
            .padding(.horizontal, 20.0)
        }
    }
    
    func signIn() {
        if (self.username == "" || self.password == "") {
            self.emptyValue = true
        } else {
            fetchAPI().getTokens(username: self.username,password: self.password) { (tokens) in
                self.tokens = tokens
                UserDefaults.standard.set(tokens[0].refreshToken, forKey:"refreshToken")
                UserDefaults.standard.synchronize()
                self.loggedIn = true
                //guard let refreshToken = UserDefaults.standard.object(forKey: "refreshToken") else { return }
                //print(refreshToken)
            }
        }
    }
}

struct PortalLoginView_Previews: PreviewProvider {
    static var previews: some View {
        PortalLoginView()
    }
}
