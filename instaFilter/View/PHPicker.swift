//
//  PHPicker.swift
//  instaFilter
//
//  Created by Максим Нуждин on 30.06.2021.
//

import PhotosUI
import SwiftUI
import StoreKit

struct PhotoPicker: UIViewControllerRepresentable {
    let configuration: PHPickerConfiguration
    @Binding var isPresented: Bool
    
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        let controller = PHPickerViewController(configuration: configuration)
        controller.delegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    // Use a Coordinator to act as your PHPickerViewControllerDelegate
    class Coordinator: PHPickerViewControllerDelegate {
      
        private let parent: PhotoPicker
        
        init(_ parent: PhotoPicker) {
            self.parent = parent
        }
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            print(results)
            parent.isPresented = false // Set isPresented to false because picking has finished.
        }
    }
}

struct PHPicker: View {
    
    @State var isPresentable = false
    
    var body: some View {
        
        Button("showing picker") {
            isPresentable.toggle()
        }.sheet(isPresented: $isPresentable, content: {
            let configuration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
            PhotoPicker(configuration: configuration, isPresented: $isPresentable)
        })
    }

}

struct PHPicker_Previews: PreviewProvider {
    static var previews: some View {
        PHPicker()
    }
}
