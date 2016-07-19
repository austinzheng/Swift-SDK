//
//  KnurldAPI.swift
//  SwiftSDK
//
//  An abstraction of the Knurld web API.
//
//  Created by Ryan Conway on 7/6/16.
//  Copyright © 2016 Knurld. All rights reserved.
//

import Foundation



// User-facing convenience abstractions of endpoint families
/// Authorization-related Knurld API endpoints.
/// Access this from your KnurldAPI instance's `authorization` member, e.g. `api.authorization.authorize(...)`
public class Authorization {
    let authorization: AuthorizationEndpoint
    let requestManager: HTTPRequestManager
    
    init(url: String, requestManager: HTTPRequestManager) {
        self.authorization = AuthorizationEndpoint(url: url)
        self.requestManager = requestManager
    }
    
    /// Get Knurld API credentials given OAuth credentials.
    public func authorize(credentials credentials: OAuthCredentials,
                                      developerID: String,
                                      successHandler: (knurldCredentials: KnurldCredentials) -> Void,
                                      failureHandler: (error: HTTPRequestError) -> Void)
    {
        // Use the response and developer ID to generate KnurldCredentials for the end user as a convenience
        self.authorization.post(manager: self.requestManager, headers: (), body: credentials,
                                successHandler: { response in
                                    successHandler(knurldCredentials: KnurldCredentials(developerID: developerID, authorizationResponse: response))
                                },
                                failureHandler: failureHandler)
    }
}

/// Status-related Knurld API endpoints.
/// Access this from your KnurldAPI instance's `status` member, e.g. `api.status.get(...)`
public class Status {
    let status: StatusEndpoint
    let requestManager: HTTPRequestManager
    
    init(url: String, requestManager: HTTPRequestManager) {
        self.status = StatusEndpoint(url: url)
        self.requestManager = requestManager
    }
    
    /// Get the Knurld API status
    public func get(credentials credentials: KnurldCredentials,
                               successHandler: (ServiceStatus) -> Void,
                               failureHandler: (HTTPRequestError) -> Void)
    {
        self.status.get(manager: self.requestManager, headers: credentials, successHandler: successHandler, failureHandler: failureHandler)
    }
}

/// Application model-related Knurld API endpoints.
/// Access this from your KnurldAPI instance's `appModels` member, e.g. `api.appModels.create(...)`
public class AppModels {
    let appModels: AppModelsEndpoint
    let requestManager: HTTPRequestManager
    
    init(url: String, requestManager: HTTPRequestManager) {
        self.appModels = AppModelsEndpoint(url: url)
        self.requestManager = requestManager
    }
    
    /// Create an application model.
    public func create(credentials credentials: KnurldCredentials,
                                    request: AppModelCreateRequest,
                                    successHandler: (AppModelEndpoint) -> Void,
                                    failureHandler: (HTTPRequestError) -> Void)
    {
        self.appModels.post(manager: self.requestManager, headers: credentials, body: request, successHandler: successHandler, failureHandler: failureHandler)
    }
    
    /// Get a page of application models.
    public func getPage(credentials credentials: KnurldCredentials,
                                     successHandler: (AppModelPage) -> Void,
                                     failureHandler: (HTTPRequestError) -> Void)
    {
        self.appModels.get(manager: self.requestManager, headers: credentials, successHandler: successHandler, failureHandler: failureHandler)
    }
    
    /// Get an application model.
    public func get(credentials credentials: KnurldCredentials,
                                 endpoint: AppModelEndpoint,
                                 successHandler: (AppModel) -> Void,
                                 failureHandler: (HTTPRequestError) -> Void)
    {
        endpoint.get(manager: self.requestManager, headers: credentials, successHandler: successHandler, failureHandler: failureHandler)
    }
    
    /// Update an application model.
    public func update(credentials credentials: KnurldCredentials,
                                    endpoint: AppModelEndpoint,
                                    request: AppModelUpdateRequest,
                                    successHandler: (AppModelEndpoint) -> Void,
                                    failureHandler: (HTTPRequestError) -> Void)
    {
        endpoint.post(manager: self.requestManager, headers: credentials, body: request, successHandler: successHandler, failureHandler: failureHandler)
    }
    
    /// Delete an application model.
    public func delete(credentials credentials: KnurldCredentials,
                                    endpoint: AppModelEndpoint,
                                    successHandler: () -> Void,
                                    failureHandler: (HTTPRequestError) -> Void)
    {
        endpoint.delete(manager: self.requestManager, headers: credentials, successHandler: successHandler, failureHandler: failureHandler)
    }
}

/// Consumer-related Knurld API endpoints.
/// Access this from your KnurldAPI instance's `consumers` member, e.g. `api.consumers.create(...)`
public class Consumers {
    let consumers: ConsumersEndpoint
    let consumerAuthenticate: AuthenticateConsumerEndpoint
    let requestManager: HTTPRequestManager
    
    init(consumersURL: String, consumersAuthURL: String, requestManager: HTTPRequestManager) {
        self.consumers = ConsumersEndpoint(url: consumersURL)
        self.consumerAuthenticate = AuthenticateConsumerEndpoint(url: consumersAuthURL)
        self.requestManager = requestManager
    }
    
    /// Create a consumer.
    public func create(credentials credentials: KnurldCredentials,
                                    request: ConsumerCreateRequest,
                                    successHandler: (ConsumerEndpoint) -> Void,
                                    failureHandler: (HTTPRequestError) -> Void)
    {
        self.consumers.post(manager: self.requestManager, headers: credentials, body: request, successHandler: successHandler, failureHandler: failureHandler)
    }
    
    /// Get a page of consumers.
    public func getPage(credentials credentials: KnurldCredentials,
                                     successHandler: (ConsumerPage) -> Void,
                                     failureHandler: (HTTPRequestError) -> Void)
    {
        self.consumers.get(manager: self.requestManager, headers: credentials, successHandler: successHandler, failureHandler: failureHandler)
    }
    
    /// Get a consumer.
    public func get(credentials credentials: KnurldCredentials,
                                 endpoint: ConsumerEndpoint,
                                 successHandler: (Consumer) -> Void,
                                 failureHandler: (HTTPRequestError) -> Void)
    {
        endpoint.get(manager: self.requestManager, headers: credentials, successHandler: successHandler, failureHandler: failureHandler)
    }
    
    /// Update a consumer.
    public func update(credentials credentials: KnurldCredentials,
                                    endpoint: ConsumerEndpoint,
                                    request: ConsumerUpdateRequest,
                                    successHandler: (ConsumerEndpoint) -> Void,
                                    failureHandler: (HTTPRequestError) -> Void)
    {
        endpoint.post(manager: self.requestManager, headers: credentials, body: request, successHandler: successHandler, failureHandler: failureHandler)
    }
    
    /// Delete a consumer.
    public func delete(credentials credentials: KnurldCredentials,
                                    endpoint: ConsumerEndpoint,
                                    successHandler: () -> Void,
                                    failureHandler: (HTTPRequestError) -> Void)
    {
        endpoint.delete(manager: self.requestManager, headers: credentials, successHandler: successHandler, failureHandler: failureHandler)
    }
    
    
    //@todo consumer auth
}

/// Enrollment-related Knurld API endpoints.
/// Access this from your KnurldAPI instance's `enrollments` member, e.g. `api.enrollments.create(...)`
public class Enrollments {
    let enrollments: EnrollmentsEndpoint
    let requestManager: HTTPRequestManager
    
    init(url: String, requestManager: HTTPRequestManager) {
        self.enrollments = EnrollmentsEndpoint(url: url)
        self.requestManager = requestManager
    }
    
    /// Create an enrollment.
    public func create(credentials credentials: KnurldCredentials,
                                      request: EnrollmentCreateRequest,
                                      successHandler: (EnrollmentEndpoint) -> Void,
                                      failureHandler: (HTTPRequestError) -> Void)
    {
        self.enrollments.post(manager: self.requestManager, headers: credentials, body: request, successHandler: successHandler, failureHandler: failureHandler)
    }
    
    /// Get a page of enrollments.
    public func getPage(credentials credentials: KnurldCredentials,
                                       successHandler: (EnrollmentPage) -> Void,
                                       failureHandler: (HTTPRequestError) -> Void)
    {
        self.enrollments.get(manager: self.requestManager, headers: credentials, successHandler: successHandler, failureHandler: failureHandler)
    }
    
    /// Get an enrollment.
    public func get(credentials credentials: KnurldCredentials,
                                   endpoint: EnrollmentEndpoint,
                                   successHandler: (Enrollment) -> Void,
                                   failureHandler: (HTTPRequestError) -> Void)
    {
        endpoint.get(manager: self.requestManager, headers: credentials, successHandler: successHandler, failureHandler: failureHandler)
    }
    
    /// Update an enrollment.
    public func update(credentials credentials: KnurldCredentials,
                                      endpoint: EnrollmentEndpoint,
                                      request: EnrollmentUpdateRequest,
                                      successHandler: (EnrollmentEndpoint) -> Void,
                                      failureHandler: (HTTPRequestError) -> Void)
    {
        endpoint.post(manager: self.requestManager, headers: credentials, body: request, successHandler: successHandler, failureHandler: failureHandler)
    }
    
    /// Delete an enrollment
    public func delete(credentials credentials: KnurldCredentials,
                                      endpoint: EnrollmentEndpoint,
                                      successHandler: () -> Void,
                                      failureHandler: (HTTPRequestError) -> Void)
    {
        endpoint.delete(manager: self.requestManager, headers: credentials, successHandler: successHandler, failureHandler: failureHandler)
    }
}

/// Verification-related Knurld API endpoints.
/// Access this from your KnurldAPI instance's `enrollments` member, e.g. `api.enrollments.create(...)`
public class Verifications {
    let verifications: VerificationsEndpoint
    let requestManager: HTTPRequestManager
    
    init(url: String, requestManager: HTTPRequestManager) {
        self.verifications = VerificationsEndpoint(url: url)
        self.requestManager = requestManager
    }
    
    /// Create a verification.
    public func create(credentials credentials: KnurldCredentials,
                                        request: VerificationCreateRequest,
                                        successHandler: (VerificationEndpoint) -> Void,
                                        failureHandler: (HTTPRequestError) -> Void)
    {
        self.verifications.post(manager: self.requestManager, headers: credentials, body: request, successHandler: successHandler, failureHandler: failureHandler)
    }
    
    /// Get a page of verifications.
    public func getPage(credentials credentials: KnurldCredentials,
                                         successHandler: (VerificationPage) -> Void,
                                         failureHandler: (HTTPRequestError) -> Void)
    {
        self.verifications.get(manager: self.requestManager, headers: credentials, successHandler: successHandler, failureHandler: failureHandler)
    }
    
    /// Get a verification.
    public func get(credentials credentials: KnurldCredentials,
                                     endpoint: VerificationEndpoint,
                                     successHandler: (Verification) -> Void,
                                     failureHandler: (HTTPRequestError) -> Void)
    {
        endpoint.get(manager: self.requestManager, headers: credentials, successHandler: successHandler, failureHandler: failureHandler)
    }
    
    /// Update a verification.
    public func update(credentials credentials: KnurldCredentials,
                                        endpoint: VerificationEndpoint,
                                        request: VerificationUpdateRequest,
                                        successHandler: (VerificationEndpoint) -> Void,
                                        failureHandler: (HTTPRequestError) -> Void)
    {
        endpoint.post(manager: self.requestManager, headers: credentials, body: request, successHandler: successHandler, failureHandler: failureHandler)
    }
    
    /// Delete a verification.
    public func delete(credentials credentials: KnurldCredentials,
                                        endpoint: VerificationEndpoint,
                                        successHandler: () -> Void,
                                        failureHandler: (HTTPRequestError) -> Void)
    {
        endpoint.delete(manager: self.requestManager, headers: credentials, successHandler: successHandler, failureHandler: failureHandler)
    }
}

public class EndpointAnalyses {
    let urlAnalyses: URLEndpointAnalysisEndpoint
    let fileAnalyses: FileEndpointAnalysisEndpoint
    let requestManager: HTTPRequestManager
    
    init(urlAnalysesURL: String, fileAnalysesURL: String, requestManager: HTTPRequestManager) {
        self.urlAnalyses = URLEndpointAnalysisEndpoint(url: urlAnalysesURL)
        self.fileAnalyses = FileEndpointAnalysisEndpoint(url: fileAnalysesURL)
        self.requestManager = requestManager
    }
    
    /// Perform endpoint analysis on an audio sample given its URL.
    public func endpointURL(credentials credentials: KnurldCredentials,
                                 request: URLEndpointAnalysisCreateRequest,
                                 successHandler: (EndpointAnalysisEndpoint) -> Void,
                                 failureHandler: (HTTPRequestError) -> Void)
    {
        urlAnalyses.post(manager: self.requestManager,
                                 headers: credentials,
                                 body: request,
                                 successHandler: { summary in
                                    successHandler(EndpointAnalysisEndpoint(summary: summary)) },
                                 failureHandler: failureHandler)
    }
    
    /// Perform endpoint analysis on an audio sample given the sample contents
    public func endpointFile(credentials credentials: KnurldCredentials,
                                         request: FileEndpointAnalysisCreateRequest,
                                         successHandler: (EndpointAnalysisEndpoint) -> Void,
                                         failureHandler: (HTTPRequestError) -> Void)
    {
        fileAnalyses.post(manager: self.requestManager,
                          headers: credentials,
                          body: request,
                          successHandler: { summary in
                            successHandler(EndpointAnalysisEndpoint(summary: summary)) },
                          failureHandler: failureHandler)
    }
    
    /// Get the progress or results of an endpoint analysis.
    public func get(credentials credentials: KnurldCredentials,
                                          endpoint: EndpointAnalysisEndpoint,
                                          successHandler: (EndpointAnalysis) -> Void,
                                          failureHandler: (HTTPRequestError) -> Void)
    {
        endpoint.get(manager: self.requestManager, headers: credentials, successHandler: successHandler, failureHandler: failureHandler)
    }
}



/// KnurldAPI abstracts out the Knurld web API.
public class KnurldAPI {
    let requestManager: HTTPRequestManager
    
    // Base URL of the API, e.g. "https://api.knurld.io"
    let baseURL: String
    // Version path of the API, e.g. "/v1"
    let versionPath: String
    
    /// URL this instance of the API is configured to talk to
    public var url: String { get { return self.baseURL + self.versionPath } }
    
    // Convenience wrappers of Knurld endpoints
    /// Developer (admin) credential authorization endpoints
    public let authorization: Authorization
    
    /// API status endpoints
    public let status: Status
    
    /// Application model endpoints
    public let appModels: AppModels
    
    /// Consumer endpoints
    public let consumers: Consumers
    
    /// Enrollment endpoints
    public let enrollments: Enrollments
    
    /// Verification endpoints
    public let verifications: Verifications
    
    /// Endpoint analysis endpoints
    public let endpointAnalyses: EndpointAnalyses
    
    /// Initialize a Knurld API using a custom URL and version path, instead of e.g. "https://api.knurld.io" and "/v1"
    init(baseURL: String, versionPath: String) {
        self.requestManager = HTTPRequestManager()
        
        self.baseURL = baseURL
        self.versionPath = versionPath
        
        let url = self.baseURL + self.versionPath
        
        self.authorization = Authorization(url: self.baseURL + "/oauth/client_credential/accesstoken?grant_type=client_credentials", requestManager: self.requestManager)
        self.status = Status(url: url + "/status", requestManager: self.requestManager)
        self.appModels = AppModels(url: url + "/app-models", requestManager: self.requestManager)
        self.consumers = Consumers(consumersURL: url + "/consumers", consumersAuthURL: url + "/consumers/token", requestManager: self.requestManager)
        self.enrollments = Enrollments(url: url + "/enrollments", requestManager: self.requestManager)
        self.verifications = Verifications(url: url + "/verifications", requestManager: self.requestManager)
        self.endpointAnalyses = EndpointAnalyses(urlAnalysesURL: url + "/endpointAnalysis/url", fileAnalysesURL: url + "/endpointAnalysis/file",requestManager: self.requestManager)
    }
    
    /// Initialize a Knurld API using a custom URL, instead of e.g. "https://api.knurld.io"
    public convenience init(url: String) {
        self.init(baseURL: url, versionPath: EndpointCommons.DEFAULT_VERSION_PATH)
    }
    
    /// Initialize a Knurld API using the default URL
    public convenience init() {
        self.init(baseURL: EndpointCommons.DEFAULT_BASE_URL, versionPath: EndpointCommons.DEFAULT_VERSION_PATH)
    }
}

