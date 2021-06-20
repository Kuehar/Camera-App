//
//  ImagePickerView.swift
//  Camera-App
//
//  Created by kuehar on 2021/06/20.
//

import SwiftUI

struct ImagePickerView: UIViewControllerRepresentable {
    // 写真撮影が表示されているか
    @Binding var isShowSheet: Bool
    @Binding var captureImage: UIImage?
    
    class Coordinator: NSObject,
                       UINavigationControllerDelegate,
                       UIImagePickerControllerDelegate{
        // ImagePickerView型の変数を用意
        let parent: ImagePickerView
        init(_ parent:ImagePickerView){
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
                parent.captureImage = originalImage
            }
            parent.isShowSheet = false
        }
    }
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePickerView>) -> UIImagePickerController {
        let myImagePickerController = UIImagePickerController()
        myImagePickerController.sourceType = .camera
        myImagePickerController.delegate = context.coordinator
        return myImagePickerController
    }
    
    func updateUIViewController(
        _ uiViewController:UIImagePickerController,context:UIViewControllerRepresentableContext<ImagePickerView>)
    {
        // 処理なし
    }
}
