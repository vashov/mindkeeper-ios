//
//  NodeView.swift
//  Mindkeeper
//
//  Created by Борис Вашов on 21.02.2022.
//

import SwiftUI

struct NodeView: View {
    
    static let width = CGFloat(100)
    // 1
    @State var node: Node
    //2
    @ObservedObject var selection: SelectionHandler
    //3
    var isSelected: Bool {
      return selection.isNodeSelected(node)
    }
    
    private let cornerWidthSize = 15
    private let cornerHeightSize = 15
    
    private let fillColor = Color(red: 0.949, green: 0.949, blue: 0.97, opacity: 1.0)
    var body: some View {
        BuildRoundedRectangle()
//            .fill(Color.gray)
            .fill(fillColor)
            .frame(width: 150, height: 110)
          .overlay(BuildRoundedRectangle()
            .stroke(isSelected ? Color.red : Color.black, lineWidth: isSelected ? 5 : 2))
          .overlay(Text(node.text)
            .multilineTextAlignment(.center)
            .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)))
          .frame(width: NodeView.width, height: NodeView.width, alignment: .center)
    }
    
    private func BuildRoundedRectangle() -> RoundedRectangle {
        RoundedRectangle(cornerSize: CGSize(width: cornerWidthSize, height: cornerHeightSize))
    }
}

struct NodeView_Previews: PreviewProvider {
    static var previews: some View {
        let node = Node(id: UUID(), position: .zero, text: "Some node choose your size lurum ipsum many time")
        let selectionHandler = SelectionHandler()
        NodeView(node: node, selection: selectionHandler)
    }
}
