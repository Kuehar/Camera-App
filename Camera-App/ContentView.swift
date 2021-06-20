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
    @State var isPhotolibrary = false
    @State var isShowAction = false
    

    
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
            .sheet(isPresented: $isShowSheet) {
                // フォトライブラリーが選択された
                if isPhotolibrary {
                    // PHPickerViewController(フォトライブラリー)を表示
                    PHPickerView(
                        isShowSheet: $isShowSheet,
                        captureImage: $captureImage)
                } else {
                    // UIImagePickerController（写真撮影） を表示
                    ImagePickerView(
                        isShowSheet: $isShowSheet,
                        captureImage: $captureImage)
                }
            } // 「カメラを起動する」ボタンのsheetここまで
            // 状態変数:$isShowActionに変化があったら実行
            .actionSheet(isPresented: $isShowAction) {
                // ActionSheetを表示するin
                ActionSheet(title: Text("確認"),
                            message: Text("選択してください"),
                            buttons: [
                    .default(Text("カメラ"), action: {
                        // カメラを選択
                        isPhotolibrary = false
                        // カメラが利用可能かチェック
                        if UIImagePickerController.isSourceTypeAvailable(.camera){
                            print("カメラは利用できます")
                            // カメラが使えるなら、isShowSheetをtrue
                            isShowSheet = true
                        } else {
                            print("カメラは利用できません")
                        }
                    }),
                    .default(Text("フォトライブラリー"), action: {
                        // フォトライブラリーを選択
                        isPhotolibrary = true
                        // isShowSheetをtrue
                        isShowSheet = true
                    }),
                    // キャンセル
                    .cancel(),
                ]) // ActionSheetここまで
            } // .actionSheetここまで
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
