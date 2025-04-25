//
//  CoinImageService.swift
//  CryptoSwiftUI
//
//  Created by Phuc Huu Do on 22/4/25.
//

import Foundation
import SwiftUI
import Combine

class CoinImageService {
    
    @Published var image: UIImage? = nil
    
    private var imageSubscription: AnyCancellable?
    private let coin: CoinModel
    private let fileManager = LocalFileManager.instance
    private let folderName = "coin_images"
    private let imageName: String
    
    init(coin: CoinModel) {
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }
    
    private func getCoinImage() {
        if let savedImage = fileManager.getImage(imageName: imageName, folderName: folderName) {
            image = savedImage
            print("Retrieved image fro")
        } else {
            downloadCoinImage()
            print("Downloading image now")
        }
    }
    
    private func downloadCoinImage() {
        guard let url = URL(string: coin.image) else { return }
        print("Download image now")
        imageSubscription = NetworkingManager.download(url: url)
            .map({ (data) -> UIImage? in // should we use trymap?
                return UIImage(data: data)
            })
            .sink(
                receiveCompletion: NetworkingManager.handleCompletion,
                receiveValue: { [weak self] returnedImage in
                    if let downloadedImage = returnedImage {
                        self?.handleDownloadedImage(downloadedImage)
                    }
                })
    }
    
    private func handleDownloadedImage(_ image: UIImage) {
        self.image = image
        self.imageSubscription?.cancel()
        self.fileManager.saveImage(image: image, imageName: imageName, folderName: folderName)
    }
}
