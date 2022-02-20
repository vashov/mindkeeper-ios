//
//  CreateIdeaButtonStyle.swift
//  Mindkeeper
//
//  Created by Борис Вашов on 17.02.2022.
//

import Foundation

import SwiftUI

struct CreateIdeaButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            Circle()
                .foregroundColor(Color.white)
                .frame(width: 80, height: 80)
                .shadow(radius: 2)
            configuration.label
                .foregroundColor(.primary)
                .frame(width: 60, height: 60)
        }
        .opacity(configuration.isPressed ? 0.2 : 1)
    }
}


struct CreateIdeaButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Button("Press Me") {
            print("Button pressed!")
        }
        .buttonStyle(MainButtonStyle())
    }
}
