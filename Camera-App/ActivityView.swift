//
//  ActivityView.swift
//  Camera-App
//
//  Created by kuehar on 2021/06/20.
//

import SwiftUI

struct ActivityView: UIViewControllerRepresentable {

    // UIActivityViewController（シェア機能）でシェアする写真
    let shareItems: [Any]

    // 表示するViewを生成するときに実行
    func makeUIViewController(context: Context) ->
        UIActivityViewController {
        
         // UIActivityViewControllerでシェアする機能を生成
        let controller = UIActivityViewController(
                        activityItems: shareItems,
                        applicationActivities: nil)
        
        // UIActivityViewControllerを返す
        return controller
    }

    // Viewが更新されたときに実行
    func updateUIViewController(
        _ uiViewController: UIActivityViewController,
        context: UIViewControllerRepresentableContext<ActivityView>)
    {
        // 処理なし
    }
} // ActivityViewここまで
