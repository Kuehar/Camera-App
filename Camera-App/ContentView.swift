//
//  ContentView.swift
//  Camera-App
//
//  Created by kuehar on 2021/06/20.
//

import SwiftUI

struct ContentView: View {
    
    @State var captureImage: UIImage? = nil
    @State var isShowSheet = false
    @State var isShowActivity = false

    
    var body: some View {
        VStack{
            Spacer()
            if let unwrappedCaptureImage = captureImage{
                Image(uiImage: unwrappedCaptureImage)
                    .resizable()
                    .aspectRatio(contentMode:.fit)
            }
            
            Spacer()

            Button(action:{
                if UIImagePickerController.isSourceTypeAvailable(.camera){
                    print("カメラが利用できます")
                    isShowSheet = true
                }else{
                    print("カメラが利用できません")
                }
                   
                   }){
                Text("カメラを起動する")
                    .frame(maxWidth:.infinity)
                    .frame(height:50)
                    .multilineTextAlignment(.center)
                    .background(Color.blue)
                    .foregroundColor(Color.white)

            }
            .padding()
            .sheet(isPresented: $isShowSheet){
                ImagePickerView(isShowSheet: $isShowSheet, captureImage: $captureImage)
            }
            Button(action: {
                // ボタンをタップしたときのアクション
                // 撮影した写真があるときだけ
                // UIActivityViewController（シェア機能）を表示
                if let _ = captureImage {
                    isShowActivity = true
                }
            }) {
                Text("SNSに投稿する")
                    // 横幅いっぱい
                    .frame(maxWidth: .infinity)
                    // 高さ50ポイントを指定
                    .frame(height: 50)
                    // 文字列をセンタリング指定
                    .multilineTextAlignment(.center)
                    // 背景を青色に指定
                    .background(Color.blue)
                    // 文字色を白色に指定
                    .foregroundColor(Color.white)
            } // 「SNSに投稿する」ボタンここまで
            // 上下左右に余白を追加
            .padding()
            // sheetを表示
            // isPresentedで指定した状態変数がtrueのとき実行
            .sheet(isPresented: $isShowActivity) {
                // UIActivityViewController（シェア機能）を表示
                ActivityView(shareItems: [captureImage!])
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
