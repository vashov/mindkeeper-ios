/// Copyright (c) 2020 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import SwiftUI

typealias AnimatablePoint = AnimatablePair<CGFloat, CGFloat>
typealias AnimatableCorners = AnimatablePair<AnimatablePoint, AnimatablePoint>

struct EdgeView: Shape {
  var startx: CGFloat = 0
  var starty: CGFloat = 0
  var endx: CGFloat = 0
  var endy: CGFloat = 0
  
  // 1
  init(edge: EdgeProxy) {
    // 2
    startx = edge.start.x
    starty = edge.start.y
    endx = edge.end.x
    endy = edge.end.y
  }
  
  // 3
  func path(in rect: CGRect) -> Path {
    var linkPath = Path()
    linkPath.move(to: CGPoint(x: startx, y: starty)
      .alignCenterInParent(rect.size))
    linkPath.addLine(to: CGPoint(x: endx, y:endy)
      .alignCenterInParent(rect.size))
    return linkPath
  }
  
  var animatableData: AnimatableCorners {
    get { AnimatablePair(
      AnimatablePair(startx, starty),
      AnimatablePair(endx, endy))
    }
    set {
      startx = newValue.first.first
      starty = newValue.first.second
      endx = newValue.second.first
      endy = newValue.second.second
    }
  }
}

struct EdgeView_Previews: PreviewProvider {
  static var previews: some View {
    let edge1 = EdgeProxy(
      id: UUID(),
      start: CGPoint(x: -100, y: -100),
      end: CGPoint(x: 100, y: 100))
    let edge2 = EdgeProxy(
      id: UUID(),
      start: CGPoint(x: 100, y: -100),
      end: CGPoint(x: -100, y: 100))
    return ZStack {
      EdgeView(edge: edge1).stroke(lineWidth: 4)
      EdgeView(edge: edge2).stroke(Color.blue, lineWidth: 2)
    }
  }
}
