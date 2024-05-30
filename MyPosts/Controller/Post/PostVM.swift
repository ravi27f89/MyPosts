//
//  PostVM.swift
//  MyPosts
//

import Foundation

protocol PostVMDelegate: AnyObject {
    func postVMDidUpdate(_ viewModel: PostVM)
}

final class PostVM {

    init() {
        requestPostWebService()
    }

    var delegate: PostVMDelegate?

    private var posts: [PostModel] = [] {
        didSet {
            delegate?.postVMDidUpdate(self)
        }
    }

    var postCount: Int {
        return posts.count
    }

    func post(at index: Int) -> PostModel {
        return posts[index]
    }

    /// Variables property
    func requestPostWebService() {
        WSManager.shared.getPosts { res in
            switch(res){
                case .success(let response):
                    self.posts = response
                /*if self.nextPage == 1 {
                    self.posts = response
                } else {
                    let arr = response
                    self.posts.append(respose)
                }*/
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
}
