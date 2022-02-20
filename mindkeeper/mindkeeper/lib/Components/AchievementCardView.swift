import SwiftUI

struct AchievementCardView: View {
    let title: String
    let description: String
    let isSecret: Bool
    let userGot: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Label(title, systemImage: userGot ? "rosette" : "lock")
                Spacer()
            }
            .padding(.bottom)
            HStack {
                Text(isSecret && !userGot ? "Secret achievement" : description)
                Spacer()
            }
            .font(.caption)
        }
        .foregroundColor(Color.foregroundThird)
        .padding()
        .frame(width: UIScreen.main.bounds.width - 30)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(userGot ? Color.backgroundPrimary : Color(UIColor.lightGray))
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                .frame(width: UIScreen.main.bounds.width - 30)
        )
        //        .disabled(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
        .frame(width: UIScreen.main.bounds.width - 30)
        .padding(.bottom)
        .padding(.horizontal)
    }
}

struct TaskCardView_Previews: PreviewProvider {
    static var previews: some View {
        AchievementCardView(title: "Help with moving",
                     description: "Some achievements description",
                     isSecret: false,
                     userGot: true)
        
//        AchievementCardView(title: "Help with moving",
//                     description: "Some achievements description",
//                     isSecret: true,
//                     userGot: false)
    }
}
