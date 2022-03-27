//
//  ContentView.swift
//  FireAuth
//
//  Created by Koulu on 25.3.2022.
//

import SwiftUI
import FirebaseAuth // Firebase auth


// Firebase auth
class AppViewModel: ObservableObject {
    let auth = Auth.auth()
    
    /* @Published Updates the view in real time when ever it changes because its binding  */
    @Published var signedIn = false
    
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            // Success
            DispatchQueue.main.async {
                self?.signedIn = true
            }
        }
    }
    
    func signUp(email: String, password: String) {
        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            // Success
            DispatchQueue.main.async {
                self?.signedIn = true
            }
        }
    }
    
    func signOut() {
        try? auth.signOut()
        self.signedIn = false
    }
    
}


struct ContentView: View {
    @EnvironmentObject var viewModel: AppViewModel      // Firebase auth
    
    var body: some View {
        NavigationView {
            if viewModel.signedIn {
                VStack {
                    Text("You are logged in")
                    Button {
                        viewModel.signOut()
                    } label: {
                        Text("Sign out")
                            .frame(width: 200, height: 50)
                            .foregroundColor(Color.white)
                            .background(Color.gray)
                    }
                }
                
                
            }
            else {
                SignInView()
            }
        }
        .onAppear {
            viewModel.signedIn = viewModel.isSignedIn
        }
    }
}








struct SignInView: View {
    @State var email = ""                               // Firebase auth
    @State var password = ""                            // Firebase auth
    @EnvironmentObject var viewModel: AppViewModel      // Firebase auth
    
    var body: some View {
        
        NavigationView {
            VStack {
                TextField("Email address", text: $email)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                SecureField("Password", text: $password)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                Button {
                    guard !email.isEmpty, !password.isEmpty else {
                        return
                    }
                    viewModel.signIn(email: email, password: password)  // Firebase auth
                } label: {
                    Text("sign in")
                        .foregroundColor(Color.white)
                        .frame(width: 200, height: 50)
                        .cornerRadius(40)
                        .background(Color.blue)
                }
                
                NavigationLink("Create a new account", destination: SignUpView())
                    .padding()
            }
            .padding()
        }
        .navigationTitle("Sign in")
    }
}


struct SignUpView: View {
    @State var email = ""                               // Firebase auth
    @State var password = ""                            // Firebase auth
    @EnvironmentObject var viewModel: AppViewModel      // Firebase auth
    
    var body: some View {
        
        NavigationView {
            VStack {
                TextField("Email address", text: $email)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                SecureField("Password", text: $password)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                Button {
                    guard !email.isEmpty, !password.isEmpty else {
                        return
                    }
                    viewModel.signUp(email: email, password: password)  // Firebase auth
                } label: {
                    Text("Create account")
                        .foregroundColor(Color.white)
                        .frame(width: 200, height: 50)
                        .cornerRadius(40)
                        .background(Color.blue)
                }
                
            }
            .padding()
        }
        .navigationTitle("Create account")
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}
