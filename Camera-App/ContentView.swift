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
    @State var isPhotolibrary = false
    @State var isShowAction = false
    

    
    var body: some View {
        VStack{
            Spacer()

            Button(action:{
                    // ボタンをタップしたときのアクション
                    // 撮影写真を初期化する
                    captureImage = nil
                    // ActionSheetを表示する
                    isShowAction = true
                   
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
            }
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
