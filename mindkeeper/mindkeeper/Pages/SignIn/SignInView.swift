import SwiftUI

struct SignInView: View {
    @EnvironmentObject var appState: AppState
    
    @StateObject var viewModel = SignInViewModel()
    
    var body: some View {
        LoadingView(isShowing: $viewModel.isLoading) {
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
                        .foregroundColor(.foregroundSecond)
                        .bold()
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 30)
                        .background(Color.backgroundSecond)
                        .opacity(viewModel.isValidForm ? 1 : 0.8)
                        .clipShape(Capsule())
                }
                .padding(.top, 22)
                .disabled(viewModel.isButtonDisabled)
                
                HStack {
                    Text("Don't have an account?")
                        .foregroundColor(Color.black.opacity(0.5))
                    
                    Button(action: { viewModel.showSignUp.toggle() }, label: {
                        Text("Sign Up Now")
                            .foregroundColor(.foregroundPrimary)
                    })
                }
                .padding(.top, 22)
                
                Spacer(minLength: 0)
            }
            
        }
        .background(Color.backgroundPrimary)
        //        .ignoresSafeArea(.all, edges: .all)
        .fullScreenCover(isPresented: $viewModel.showSignUp, content: {
            SignUpView()
        })
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
