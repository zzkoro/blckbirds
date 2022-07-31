//
//  ContentView.swift
//  LoginPage
//
//  Created by junemp on 2022/07/31.
//

import SwiftUI

let storedUsername = "Myusername"
let storedPassword = "Mypassword"

struct ContentView: View {
    
    @State var username = ""
    @State var password = ""
    
    @State var authenticationDidFail = false
    @State var authenticationDidSucceed = false
    
    var body: some View {
        ZStack {
            VStack {
                WelcomeText()
                UserImage()
                UsernameTextField(username: $username)
                PasswordSecureField(password: $password)
                    .onSubmit {
                        tryToLogin()
                    }
                if authenticationDidFail {
                    Text("Entered credentials incorrect. Try again.")
                        .padding(.bottom, 15)
                        .foregroundColor(.red)
                }
                Button(action: {
                    tryToLogin()
                }) {
                    LoginButtonContent()
                }
                .disabled(!username.isEmpty && !password.isEmpty ? false : true)
                .opacity(!username.isEmpty && !password.isEmpty ? 1 : 0.4)
            }
            .padding()
            if authenticationDidSucceed {
                Text("Login successful!")
                    .font(.headline)
                    .frame(width: 250, height: 60)
                    .background(Color.green)
                    .cornerRadius(20)
                    .foregroundColor(.white)
                    .animation(Animation.default)
                    
            }
        }
    }
    
    func tryToLogin() {
        if username == storedUsername && password == storedPassword {
            authenticationDidSucceed = true
            authenticationDidFail = false
        } else {
            authenticationDidFail = true
            password = ""
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct WelcomeText: View {
    var body: some View {
        Text("Welcome!")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .padding(.bottom, 20)
    }
}

struct UserImage: View {
    var body: some View {
        Image("ProfilePicture")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 150, height: 150)
            .clipped()
            .cornerRadius(150)
            .padding(.bottom, 75)
    }
}

struct LoginButtonContent: View {
    var body: some View {
        Text("LOGIN")
            .font(.headline)
            .foregroundColor(.white)
            .padding(10)
            .frame(width: 220, height: 60)
            .background(Color.green)
            .cornerRadius(15.0)
    }
}

struct UsernameTextField: View {
    
    @Binding var username: String
    
    var body: some View {
        TextField("Username", text: $username)
            .padding()
            .background(Color("LightGray"))
            .cornerRadius(5)
            .padding(.bottom, 20)
    }
}

struct PasswordSecureField: View {
    
    @Binding var password: String
    
    var body: some View {
        SecureField("Password", text: $password)
            .padding()
            .background(Color("LightGray"))
            .cornerRadius(5)
            .padding(.bottom, 20)
    }
}
