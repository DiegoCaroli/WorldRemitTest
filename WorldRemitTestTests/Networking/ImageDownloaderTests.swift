//
//  ImageDownloaderTests.swift
//  WorldRemitTest
//
//  Created by Diego Caroli on 27/02/2020.
//  Copyright © 2020 Diego Caroli. All rights reserved.
//

import XCTest
@testable import WorldRemitTest

class ImageDownloaderTests: XCTestCase {

    var sut: ImageDownloader!
    var mockImageCache: NSCache<NSString, UIImage>!
    var mockQueue: DispatchQueue!
    var mockURL: URL!
    var mockFakeURL: URL!

    override func setUp() {
        super.setUp()
        mockImageCache = NSCache<NSString, UIImage>()
        mockQueue = DispatchQueue(label: "ImageDownlaoderMock")
        sut = ImageDownloader(imageCache: mockImageCache,
                              queue: mockQueue)
        mockURL = URL(string: "https://test.com/testImage")
        mockFakeURL = URL(string: "fake-url")
    }

    override func tearDown() {
        mockImageCache = nil
        mockQueue = nil
        sut = nil
        mockURL = nil
        mockFakeURL = nil
        super.tearDown()
    }

    func test_ImageDownloader_WhenDownloadImageIsCalled() {
        let cacheExpectation = expectation(description: "Cache")

        let bundle = Bundle(for: ImageDownloaderTests.self)
        let mockImageURL = bundle.url(forResource: "mockImage", withExtension: "jpeg")!
        sut.downloadImage(fromURL: mockImageURL) { image in
            XCTAssertNotNil(image)
        }

        mockQueue.sync {
            cacheExpectation.fulfill()
        }

        wait(for: [cacheExpectation], timeout: 1)
    }

    func test_ImageDownloader_WhenImageIsCached() {
        let cacheExpectation = expectation(description: "Cahce")

        mockImageCache.setObject(UIImage(),
                                 forKey: mockURL.absoluteString as NSString)
        sut.imageCache = mockImageCache

        sut.downloadImage(fromURL: mockURL) { image in
             XCTAssertNotNil(image)
         }

        mockQueue.sync {
            cacheExpectation.fulfill()
        }

        wait(for: [cacheExpectation], timeout: 1)
    }
    
    func test_ImageDownloader_WhenCacheStringIsSetted() {
        let cacheExpectation = expectation(description: "Cache")
        sut.imageCache.setObject(UIImage(), forKey: self.mockURL.absoluteString as NSString)

        sut.downloadImage(fromURL: mockURL) { image in
            XCTAssertNotNil(self.sut.imageCache
                .object(forKey: self.mockURL!.absoluteString as NSString))
        }

        mockQueue.sync {
            cacheExpectation.fulfill()
        }

        wait(for: [cacheExpectation], timeout: 1)
    }

    func test_ImageDownloader_WhenDownloadImageIsCalledWithFakeURL() {
        let cacheExpectation = expectation(description: "Cache")

        sut.downloadImage(fromURL: mockFakeURL) { image in
            XCTAssertNil(image)
        }

        mockQueue.sync {
            cacheExpectation.fulfill()
        }

        wait(for: [cacheExpectation], timeout: 1)
    }

}
