//
//  EffectView.swift
//  Camera-App
//
//  Created by kuehar on 2021/06/21.
//

import SwiftUI

struct EffectView: View {
    @Binding var isShowSheet: Bool
    let captureImage:UIImage
    @State var showImage:UIImage?
    @State var isShowActivity = false
    
    
    var body: some View {
        VStack{
            Spacer()
            
            if let unwrapShowImage = showImage{
                Image(uiImage: unwrapShowImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            Spacer()
            Button(action: {
                // ボタンタップ時のアクション
            }){
                Text("エフェクト")
                    .frame(maxWidth:.infinity)
                    .frame(height:50)
                    .multilineTextAlignment(.center)
                    .background(Color.white)
                    .foregroundColor(Color.white)
            }
            .padding()
            
            Button(action: {
                
            }){
                Text("閉じる")
                    .frame(maxWidth:.infinity)
                    .frame(height:50)
                    .multilineTextAlignment(.center)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
            }
            .padding()
        }
        onAppear(){
            showImage = captureImage
        }
    }
}

struct EffectView_Previews: PreviewProvider {
    static var previews: some View {
        EffectView()
    }
}
