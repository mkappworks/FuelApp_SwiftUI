//
//  ScanButton.swift
//  FuelApp_SwiftUI
//
//  Created by Malith Kuruppu on 2022-08-26.
//

import SwiftUI

struct ScanButton: UIViewRepresentable {
    @Binding var scannedText: String
     var buttonImageName: String
     var buttonTitle: String

    func makeUIView(context: Context) -> UIButton {

      let textFromCamera = UIAction.captureTextFromCamera(
        responder: context.coordinator,
        identifier: nil)

      let button = UIButton(primaryAction: textFromCamera)
        
    button.setImage(
                  UIImage(systemName: buttonImageName),
                  for: .normal)
        
        button.setTitle(buttonTitle, for: .normal)
        
    return button
  }

  func updateUIView(_ uiView: UIButton, context: Context) { }

  func makeCoordinator() -> Coordinator {
      Coordinator(self)
    }
}


class Coordinator: UIResponder, UIKeyInput {
  let parent: ScanButton
  init(_ parent: ScanButton) { self.parent = parent }

  var hasText = false
    
  func insertText(_ text: String) {parent.scannedText = "\(text)"}
    
  func deleteBackward() { }
}

struct ScanButton_Previews: PreviewProvider {
  static var previews: some View {
      ScanButton(scannedText: .constant(""), buttonImageName: "camera.badge.ellipsis", buttonTitle: "Input Fuel")

  }
}

