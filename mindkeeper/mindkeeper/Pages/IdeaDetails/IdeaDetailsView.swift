//
//  IdeaDetailsView.swift
//  Mindkeeper
//
//  Created by Борис Вашов on 20.02.2022.
//

import SwiftUI

struct IdeaDetailsView: View {
    @StateObject var viewModel = IdeaDetailsViewModel()
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        LoadingView(isShowing: $viewModel.isLoading) {
            VStack {
                TextField("Title", text: $viewModel.name)
                TextField("Description", text: $viewModel.text)
                
                Spacer()
                
                if viewModel.isNewIdea {
                    Button(action:  { viewModel.createIdea() {
                        self.presentationMode.wrappedValue.dismiss()
                    }}) {
                        Text("Create")
                    }
                    .disabled(!viewModel.isValidForm)
                    .buttonStyle(MainButtonStyle())
                } else {
                    Button(action: viewModel.updateIdea) {
                        Text("Update")
                    }
                    .disabled(!viewModel.isValidForm)
                    .buttonStyle(MainButtonStyle())
                }
            }
            .padding()
            .navigationTitle(viewModel.isNewIdea ? "new idea" : "idea")
        }
    }
}

struct IdeaDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        IdeaDetailsView()
    }
}
