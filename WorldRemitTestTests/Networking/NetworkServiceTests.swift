//
//  NetworkServiceTests.swift
//  WorldRemitTestTests
//
//  Created by Diego Caroli on 26/02/2020.
//  Copyright © 2020 Diego Caroli. All rights reserved.
//

import XCTest
@testable import WorldRemitTest

class NetworkServiceTests: XCTestCase {
    
    var sut: NetworkingService!
    var mockURLSession: MockURLSession!
    var mockURL: URL!
    
    override func setUp() {
        super.setUp()

        mockURLSession = MockURLSession(data: nil, urlResponse: nil, error: nil)
        mockURL = URL(string: "https://test.com/2.2/users?pagesize=20&order=desc&sort=reputation&site=stackoverflow")
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_Exchanges_UsesExpectedHost() {
        let jsonData = try! Data.fromJSON(fileName: "GET_Users_ValidResponse")
        let urlResponse = HTTPURLResponse(url: mockURL,
                                          statusCode: 200,
                                          httpVersion: nil,
                                          headerFields: nil)
        mockURLSession = MockURLSession(data: jsonData,
                                        urlResponse: urlResponse,
                                        error: nil)
        setupSession(mockURLSession)

        sut.execute(Endpoint.users) { (result: (Result<Users, Error>)) in

        }

        XCTAssertEqual(mockURLSession.urlComponents?.host,
                       "api.stackexchange.com")
    }
    
    func test_Exchanges_UsesExpectedPath() {
                let jsonData = try! Data.fromJSON(fileName: "GET_Users_ValidResponse")
        let urlResponse = HTTPURLResponse(url: mockURL,
                                          statusCode: 200,
                                          httpVersion: nil,
                                          headerFields: nil)
        mockURLSession = MockURLSession(data: jsonData,
                                        urlResponse: urlResponse,
                                        error: nil)
        setupSession(mockURLSession)

        sut.execute(Endpoint.users) { (result: (Result<Users, Error>)) in

        }
        XCTAssertEqual(mockURLSession.urlComponents?.path,
                       "/2.2/users")
    }
    
    func test_Exchanges_WhenSuccessful() {
        let jsonData = try! Data.fromJSON(fileName: "GET_Users_ValidResponse")
        let urlResponse = HTTPURLResponse(url: mockURL,
                                          statusCode: 200,
                                          httpVersion: nil,
                                          headerFields: nil)
        mockURLSession = MockURLSession(data: jsonData,
                                        urlResponse: urlResponse,
                                        error: nil)
        setupSession(mockURLSession)
        
        let successfulExpectation = expectation(description: "Successful")
        sut.execute(Endpoint.users) { (result: (Result<Users, Error>)) in
            switch result {
            case .success(let users):
                XCTAssertNotNil(users)
                successfulExpectation.fulfill()
            case .failure(_):
                XCTFail()
            }
        }
        wait(for: [successfulExpectation], timeout: 1)
    }
    
    func test_Exchanges_WhenJSONIsInvalid() {
        let jsonData = try! Data.fromJSON(fileName: "GET_Users_MissingValuesResponse")
        let urlResponse = HTTPURLResponse(url: mockURL,
                                          statusCode: 200,
                                          httpVersion: nil,
                                          headerFields: nil)
        mockURLSession = MockURLSession(data: jsonData,
                                        urlResponse: urlResponse,
                                        error: nil)
        setupSession(mockURLSession)
        
        let errorExpectation = expectation(description: "Error")
        sut.execute(Endpoint.users) { (result: (Result<Users, Error>)) in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                XCTAssertNotNil(error)
                errorExpectation.fulfill()
            }
        }
        wait(for: [errorExpectation], timeout: 1)
    }
    
    func test_Exchanges_WhenDataIsNil() {
        mockURLSession = MockURLSession(data: nil,
                                        urlResponse: nil,
                                        error: nil)
        setupSession(mockURLSession)
        
        let errorExpectation = expectation(description: "Error")
        sut.execute(Endpoint.users) { (result: (Result<Users, Error>)) in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                XCTAssertNotNil(error)
                errorExpectation.fulfill()
            }
        }
        wait(for: [errorExpectation], timeout: 1)
    }
    
    func test_Exchanges_WhenResponseHasError() {
        let jsonData = try! Data.fromJSON(fileName: "GET_Users_ValidResponse")
        let error = NSError(domain: "SomeError",
                            code: 1234,
                            userInfo: nil)
        mockURLSession = MockURLSession(data: jsonData,
                                        urlResponse: nil,
                                        error: error)
        setupSession(mockURLSession)
        
        let errorExpectation = expectation(description: "Error")
        sut.execute(Endpoint.users) { (result: (Result<Users, Error>)) in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                XCTAssertNotNil(error)
                errorExpectation.fulfill()
            }
        }
        wait(for: [errorExpectation], timeout: 1)
    }
    
    func test_Exchanges_WhenHTTPStatusError() {
        let response = HTTPURLResponse(url: mockURL,
                                       statusCode: 500,
                                       httpVersion: nil,
                                       headerFields: nil)
        mockURLSession = MockURLSession(data: Data(),
                                        urlResponse: response,
                                        error: nil)
        setupSession(mockURLSession)
        
        let errorExpectation = expectation(description: "Error")
        sut.execute(Endpoint.users) { (result: (Result<Users, Error>)) in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                XCTAssertNotNil(error)
                errorExpectation.fulfill()
            }
        }
        wait(for: [errorExpectation], timeout: 1)
    }
    
}

private extension NetworkServiceTests {
    func setupSession(_ session: MockURLSession) {
        sut = NetworkingService(session: session)
    }

}
