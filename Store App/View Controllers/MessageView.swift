//
//  MessageView.swift
//  Store App
//
//  Created by Mohd Kashif on 10/07/24.
//

import SwiftUI
enum MessageType{
    case success
    case warning
    case error
    case info
}
struct MessageView: View {
    let title:String
    let message:String
    let type:MessageType
    private var backGorundColor:Color{
        switch type{
        case .success:
            Color.green
        case .error:
            Color.red
        case .warning:
            Color.orange
        case .info:
            Color.blue
        }
    }
    var body: some View {
        VStack(alignment:.leading, spacing: 10){
            Text(title)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(message)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .foregroundColor(.white)
        .padding()
        .background{
            backGorundColor
        }
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .padding()
    }
}

#Preview {
    MessageView(title: "Error", message: "unablet o add product", type: .warning)
}
