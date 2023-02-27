//
//  ImageDataManager.swift
//  WantedProjectApp
//
//  Created by 한성봉 on 2023/02/21.
//

import UIKit


class ImageDataManager {
    var loadImageArray: [String] = []
    
    func setImageArray() {
        loadImageArray = [
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR4xdhLLF_M4g2Iz2X9q1vVlhLNjp8pkMHriw&usqp=CAU",
            "https://img.extmovie.com/files/attach/images/135/745/885/072/e9d0aa72d7ee4ffe04a697b1c3412ec6.jpg",
            "https://scs-phinf.pstatic.net/MjAyMTA4MDNfMjcy/MDAxNjI3OTgxNjQ5MDE0.vhatosxJSxxR-QeN0ZPRzbWTKFxAq2FW4kMCukcwnT0g.tfmAXhJT_XC3h-2NgtPYb99mLh02W3-j3JVFAfedDckg.JPEG/%EB%B8%94%EB%9E%99%EC%9C%84%EB%8F%84%EC%9A%B0.jpeg?type=nfs670_440",
            "https://i.ytimg.com/vi/mI9oyFMUlfg/maxresdefault.jpg",
            "https://i.ytimg.com/vi/h3rKe6DdC18/maxresdefault.jpg",
        ]
    }
    
    func getImageArray(_ idx: Int) -> String {
        return loadImageArray[idx]
    }
    
    
    
}
