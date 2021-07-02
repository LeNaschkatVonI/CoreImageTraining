//
//  ContentView.swift
//  instaFilter
//
//  Created by Максим Нуждин on 29.06.2021.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    
    @State var image: Image?
    @State private var uiKitPicker = false
    @State private var swiftUIPicker = false
    @State var sliderValue: Float = 0
    
    var body: some View {
        let value = Binding<Float> (
            get: {
                self.sliderValue
            }, set: {
                self.sliderValue = $0
            }
        )
        GeometryReader { geometry in
            VStack {
                Text("\(sliderValue)")
                image?
                    .resizable()
                    .scaledToFit()
                Slider(value: value, in: 0...1)
                Button(action: {
                    loadImage()
                }, label: {
                    Text("Update")
                })
                Button("show new image picker") {
                    swiftUIPicker.toggle()
                }.sheet(isPresented: $swiftUIPicker, content: {
                    PHPicker()
                })
            }
            .onAppear(perform: loadImage)
        }
    }
    
    func loadImage() {
        guard let inputImage = UIImage(named: "Example") else { return }
        let beginImage = CIImage(image: inputImage)
        
        let context = CIContext()
        let currentFilter = CIFilter.sepiaTone()
        
        currentFilter.inputImage = beginImage
        currentFilter.intensity = sliderValue
        
        guard let outputImage = currentFilter.outputImage else { return }
        
        if let cgimage = context.createCGImage(outputImage, from: outputImage.extent)
        {
            let uiImage = UIImage(cgImage: cgimage)
            image = Image(uiImage: uiImage)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
