import SwiftUI

struct SignInView: View {
    @EnvironmentObject var appState: AppState
    
    @StateObject var viewModel = SignInViewModel()
    
    var body: some View {
        LoadingView(isShowing: $viewModel.isLoading) {
            NavigationView {
                VStack {
                    
                    LogoView()
                        .padding(.top, 50)
                    
                    VStack(spacing: 20) {
                        CustomTextField(image: "person", placeHolder: "Username", txt: $viewModel.login)
                            .disabled(viewModel.isLoading)
                        CustomTextField(image: "lock", placeHolder: "Password", isSecurityField: true, txt: $viewModel.password)
                            .disabled(viewModel.isLoading)
                    }
                    .padding(.top)
                    .padding(.horizontal)
                    
                    Button(action:  viewModel.loginRequest) {
                        Text("SIGN IN")
                            .bold()
                            .foregroundColor(.foregroundPrimary)
                    }
                    .buttonStyle(MainButtonStyle())
                    .padding(.top, 22)
                    .disabled(viewModel.isButtonDisabled)
                    
                    HStack {
                        Text("Don't have an account?")
                            .foregroundColor(Color.black.opacity(0.5))
                        
                        NavigationLink(destination: SignUpView()) {
                            Text("Sign Up Now")
                                .foregroundColor(.foregroundPrimary)
                        }
                    }
                    .padding(.top, 22)
                    
                    Spacer(minLength: 0)
                }
                .navigationBarHidden(true)
            }
            
            
        }
        .background(Color.backgroundPrimary)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
