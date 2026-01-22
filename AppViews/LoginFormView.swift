//
//  LoginFormView.swift
//  epahichan
//
//  Created by Nabin Shrestha on 1/20/26.
//

import SwiftUI

struct LoginFormView: View {
    @State private var emailOrPhone: String = ""
    @State private var password: String = ""
    @State private var showSignUp = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 24) {
                        
                        Text("लगइन गर्नुहोस्")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        TextField("इमेल वा फोन नम्बर", text: $emailOrPhone)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .font(.title3)
                            .padding(.horizontal, 16)
                            .frame(height: 50)
                            .background(Color(.secondarySystemBackground))
                            .overlay(
                                Rectangle()
                                    .stroke(Color.blue.opacity(0.3), lineWidth: 1)
                            )
                        
                        SecureField("पासवर्ड", text: $password)
                            .font(.title3)
                            .padding(.horizontal, 16)
                            .frame(height: 50)
                            .background(Color(.secondarySystemBackground))
                            .overlay(
                                Rectangle()
                                    .stroke(Color.blue.opacity(0.3), lineWidth: 1)
                            )
                        
                        Button(action: {
                        }) {
                            Text("लगइन")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .foregroundColor(.white)
                                .background(Color.blue)
                        }
                        
                        Button(action: {
                            showSignUp = true
                        }) {
                            Text("साइन अप")
                                .font(.footnote)
                                .foregroundColor(.blue)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .padding(24)
                    .background(Color.white)
                    .padding(.horizontal, 24)
                    
                    Spacer()
                }
            }
            .navigationTitle("लगइन")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showSignUp) {
                SignUpFormView()
            }
        }
    }
}

#Preview {
    LoginFormView()
}
