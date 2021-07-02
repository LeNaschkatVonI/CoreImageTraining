//
//  beautyButtons.swift
//  instaFilter
//
//  Created by Максим Нуждин on 01.07.2021.
//

import SwiftUI

struct beautyButtons: View {
    var button: Button<Text>
    var image: Image
    @State private var numbercount = 0
    
    var body: some View {
        VStack {
            Text("\(numbercount)")
            image
                .resizable()
                .scaledToFit()
                .overlay(button)
                .onTapGesture {
                    numbercount += 1
                }
        }
    }
}

struct beautyButtons_Previews: PreviewProvider {
    static var previews: some View {
        beautyButtons( button: Button(action: {
            print("234")
        }, label: {
            Text("")
        }), image: Image(systemName: "pencil"))
    }
}
