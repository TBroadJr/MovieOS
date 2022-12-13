//
//  XMarkImage.swift
//  MovieOS
//
//  Created by Tornelius Broadwater, Jr on 12/13/22.
//

import SwiftUI

struct XMarkImage: View {
    var body: some View {
        Image(systemName: "xmark")
            .foregroundColor(.white)
            .frame(width: 40, height: 40)
            .background(.ultraThinMaterial)
            .mask(Circle())
    }
}

struct XMarkImage_Previews: PreviewProvider {
    static var previews: some View {
        XMarkImage()
    }
}
