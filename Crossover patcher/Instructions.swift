//
//  Instructions.swift
//  Crossover patcher
//
//  Created by Italo Mandara on 03/04/2023.
//
import SwiftUI

struct Instructions: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.openWindow) var openWindow
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                Image("Logo")
                    .resizable(resizingMode: .stretch)
                    .frame(width: 60.0, height: 60.0)
                
                Text(localizedCXPatcherString(forKey: "CrossOverPatcher"))
                    .fontWeight(.bold)
                    .font(.title)
                    .padding(.top, 1.0)
                
                Text(localizedCXPatcherString(forKey: "InstructionsAskWhatDo"))
                    .fontWeight(.bold)
                    .font(.title2)
                    .padding(.top, 30.0)
                
                Text(localizedCXPatcherString(forKey: "InstructionsFunctionDescription"))
                    .padding(.top, 1.0)
                    .multilineTextAlignment(.center)
                
                Text("\(localizedCXPatcherString(forKey: "Instructions")):")
                    .font(.title2)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.top, 20.0)
                
                Text(localizedCXPatcherString(forKey: "InstructionsText"))
                    .multilineTextAlignment(.center)
                    .padding(.top, 1.0)
                
                // Hyperlink works now too :)
                Text(.init("[\(localizedCXPatcherString(forKey: "CrossOverDownloadURLText"))](\(localizedCXPatcherString(forKey: "CrossOverDownloadURL")))"))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.top, 1.0)
                    .tint(.blue)
                
                Text(localizedCXPatcherString(forKey: "Credits"))
                    .font(.title2)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.top, 20.0)
                
                Text(localizedCXPatcherString(forKey: "CreditsText"))
                    .multilineTextAlignment(.center)
                    .padding(.top, 1.0)
                
                Text(.init(localizedCXPatcherString(forKey: "CreditsLinks")))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.top, 1.0)
                    .tint(.blue)
                
            }
            .padding(40)
        }
        // If you feel like this is too much of a spaghetti, correct it.
        .frame(minWidth: 600, idealWidth: 600, maxWidth: 600, minHeight: 700, idealHeight: 700, maxHeight: 700)
        .fixedSize()
    }
}

struct Disclaimer_Previews: PreviewProvider {
    static var previews: some View {
        Instructions()
    }
}
