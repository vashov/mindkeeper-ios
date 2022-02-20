import SwiftUI

struct SettingsView: View {
    
    @Inject
    var appState: AppState
    
    var body: some View {
        VStack {
            Spacer()
            Button(action: appState.signOut, label: {
                HStack {
                    Image(systemName: "power")
                    Text("Sign Out")
                        .bold()
                }
                .foregroundColor(.foregroundSecond)
                .padding(.vertical)
                .frame(width: UIScreen.main.bounds.width - 30)
                .background(Color.backgroundSecond)
                .clipShape(Capsule())
                
            })
            .padding()
        }
        .navigationBarTitle(Text("Settings"))
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
