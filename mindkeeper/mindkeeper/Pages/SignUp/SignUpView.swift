import SwiftUI

struct SignUpView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var viewModel = SignUpViewModel()

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
                    CustomTextField(
                        image: "lock",
                        placeHolder: "Password confirm",
                        isSecurityField: true,
                        txt: $viewModel.passwordRepeat)
                        .disabled(viewModel.isLoading)
                }
                .padding(.top)

                Button(action: { viewModel.registrationRequest(
                        successCallback: {
                            DispatchQueue.main.async {
                                presentationMode.wrappedValue.dismiss()
                            }
                        }) }
                ) {
                    Text("SIGN UP")
                        .foregroundColor(Color.foregroundSecond)
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
                    Text("Have an account?")
                        .foregroundColor(Color.foregroundThird.opacity(0.5))

                    Button(action: { presentationMode.wrappedValue.dismiss() }) {
                        Text("Sign In")
                            .foregroundColor(Color.foregroundPrimary)
                    }
                }
                .padding(.top, 22)

                Spacer(minLength: 0)
            }
            .padding(.horizontal)
            .background(Color.backgroundPrimary)
//            .ignoresSafeArea(.all, edges: .all)
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}