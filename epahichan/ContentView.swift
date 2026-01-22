//
//  ContentView.swift
//  epahichan
//
//  Created by Nabin Shrestha on 1/20/26.
//

import SwiftUI

struct ContentView: View {
    @State private var showLoginForm = false
    @State private var showSignUpForm = false
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                VStack(spacing: 20) {
                    // Login Button
                    Button(action: {
                        showLoginForm = true
                    }) {
                        Text("लगइन")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    
                    // Sign Up Button
                    Button(action: {
                        showSignUpForm = true
                    }) {
                        Text("साइन अप")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                }
                
                Spacer()
            }
            .navigationTitle("")
            .navigationBarHidden(true)
            .sheet(isPresented: $showLoginForm) {
                LoginFormView()
            }
            .sheet(isPresented: $showSignUpForm) {
                SignUpFormView()
            }
        }
    }
}

#Preview {
    ContentView()
}
