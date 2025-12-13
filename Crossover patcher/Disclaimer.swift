//
//  Disclaimer.swift
//  Crossover patcher
//
//  Created by Italo Mandara on 04/04/2023.
//

import SwiftUI

struct Disclaimer: View {
    @State public var inputText: String = ""
    @State private var valid: Bool = false
    @Binding var showDisclaimer: Bool
    
    var body: some View {
        VStack {
            Text(localizedCXPatcherString(forKey: "DisclaimerPleaseNoteLabelText"))
                .font(.title2)
                .multilineTextAlignment(.center)
                .fontWeight(.bold)
                .foregroundColor(.red)
            
            Text(localizedCXPatcherString(forKey: "DisclaimerText"))
                .multilineTextAlignment(.center)
                .padding(10)
                .foregroundColor(.white)
                .background(Color.red)
                .cornerRadius(UIGlobals.radius.rawValue)
            
            Spacer()
            
            Text(.init("\(localizedCXPatcherString(forKey: "CWWebsite")) [\(localizedCXPatcherString(forKey: "CWForums"))](\(localizedCXPatcherString(forKey: "CWForumsURL")))."))
                .multilineTextAlignment(.center)
                .padding(.top, 1.0)
                .tint(.blue)
            
            if(SKIP_DISCLAIMER_CHECK) {
                Button() {
                    withAnimation {
                        acceptAgreement(&showDisclaimer)
                    }
                } label: {
                    Image(systemName: "exclamationmark.triangle.fill")
                    Text(localizedCXPatcherString(forKey: "AgreeAndProceedButtonText"))
                }
                .padding(.vertical, 20.0)
                .buttonStyle(.borderedProminent)
                .tint(.red)
                .controlSize(.large)
            } else {
                Text(localizedCXPatcherString(forKey:"confirmation"))
                    .padding(.vertical, 20)
                    .fontWeight(.bold)
                    .foregroundColor(.red)
                
                TextField("", text: $inputText)
                    .onSubmit {
                        if (valid) {
                            acceptAgreement(&showDisclaimer)
                        }
                    }
                    .onChange(of: inputText) { newValue in
                        let expectedValue = localizedCXPatcherString(forKey: "confirmationValue")
                        valid = (newValue.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() == expectedValue.trimmingCharacters(in: .whitespacesAndNewlines).lowercased())
                    }
                    .disableAutocorrection(true)
                
                Button() {
                    acceptAgreement(&showDisclaimer)
                } label: {
                    Image(systemName: "exclamationmark.triangle.fill")
                    if(valid) {
                        Text(localizedCXPatcherString(forKey: "AgreeAndProceedButtonText"))
                    } else {
                        Text("\(localizedCXPatcherString(forKey: "waitFor"))")
                    }
                }
                .padding(.vertical, 20.0)
                .buttonStyle(.borderedProminent)
                .tint(.red)
                .controlSize(.large)
                .disabled(!valid)
            }
        }
    }
}
