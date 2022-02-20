//
//  MainButtonStyle.swift
//  Mindkeeper
//
//  Created by Борис Вашов on 17.02.2022.
//

import SwiftUI

struct MainButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) var isEnabled
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.backgroundPrimary)
                    .shadow(radius: 5)
                    .frame(width: UIScreen.main.bounds.width - 30)
            )
            .opacity(configuration.isPressed || !isEnabled ? 0.2 : 1)
    }
}


struct BlueButton_Previews: PreviewProvider {
    static var previews: some View {
        Button("Press Me") {
            print("Button pressed!")
        }
        .buttonStyle(MainButtonStyle())
    }
}
