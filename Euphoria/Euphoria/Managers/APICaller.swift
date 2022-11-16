//
//  APICaller.swift
//  Euphoria
//
//  Created by Assylzhan Izbassar on 04.10.2022.
//

import Foundation

final class APICaller {
    static let shared = APICaller()
    
    struct Constants {
        static let baseApiUrl = "https://api.spotify.com/v1"
    }
    
    enum APIError: Error {
        case failedToGetData
    }
    
    private init() {}
    
    public func saveAlbumToCurrentUser(album: Album, completion: @escaping (Bool) -> Void ) {
        createRequest(with: URL(string: "\(Constants.baseApiUrl)/me/albums?ids=\(album.id)"), type: .PUT) { baseRequest in
            var request = baseRequest
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard
                      let code = (response as? HTTPURLResponse)?.statusCode,
                      error == nil
                else {
                    completion(false)
                    return
                }
                
                completion(code == 200)
            }
            task.resume()
        }
    }
    
    
    public func add(track: Track, to playlist: Playlist, completion: @escaping (Bool) -> Void) {
        createRequest(with: URL(string: "\(Constants.baseApiUrl)/playlists/\(playlist.id)/tracks"), type: .POST) { baseRequest in
            
            var request = baseRequest
            let json = [
                "uris": [
                    "spotify:track:\(track.id)"
                ]
            ]
            
            request.httpBody = try? JSONSerialization.data(withJSONObject: json, options: .fragmentsAllowed)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(false)
                    return
                }
                do {
                    let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    
                    if let response = result as? [String: Any], response["snapshot_id"] as? String != nil {
                        completion(true)
                    } else {
                        completion(false)
                    }
                } catch {
                    print(error.localizedDescription)
                    completion(false)
                }
            }
            task.resume()
        }
    }

    
    public func remove(track: Track, from playlist: Playlist, completion: @escaping (Bool) -> Void) {
        createRequest(with: URL(string: "\(Constants.baseApiUrl)/playlists/\(playlist.id)/tracks"), type: .DELETE) { baseRequest in
            
            var request = baseRequest
            let json = [
                "tracks": [
                    [
                        "uri" : "spotify:track:\(track.id)"
                    ]
                ]
            ]
            
            request.httpBody = try? JSONSerialization.data(withJSONObject: json, options: .fragmentsAllowed)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(false)
                    return
                }
                do {
                    let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    
                    if let response = result as? [String: Any], response["snapshot_id"] as? String != nil {
                        completion(true)
                    } else {
                        completion(false)
                    }
                } catch {
                    print(error.localizedDescription)
                    completion(false)
                }
            }
            task.resume()
        }
    }
    
    
    // MARK: - Profile
    
    public func getCurrentUserProfile(completion: @escaping (Result<User, Error>) -> Void) {
        createRequest(with: URL(string: "\(Constants.baseApiUrl)/me"), type: .GET) { baseRequest in
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
//                    let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    let result = try JSONDecoder().decode(User.self, from: data)
//                    print(result)
                    completion(.success(result))
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    // MARK: - Browse
    
    public func getNewReleases(completion: @escaping (Result<NewReleasesResponse, Error>) -> Void) {
        createRequest(with: URL(string: "\(Constants.baseApiUrl)/browse/new-releases?limit=20"), type: .GET) { (request) in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(NewReleasesResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    public func getRecommendedGenres(completion: @escaping (Result<GenreResponse, Error>) -> Void) {
        createRequest(with: URL(string: "\(Constants.baseApiUrl)/recommendations/available-genre-seeds"), type: .GET) { (request) in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }

                do {
                    let result = try JSONDecoder().decode(GenreResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    // MARK: - Categories / Genres
    
    public func getCategories(completion: @escaping (Result<AllCategories, Error>) -> Void) {
        createRequest(with: URL(string: "\(Constants.baseApiUrl)/browse/categories?limit=30"), type: .GET) { baseRequest in
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(AllCategories.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    
    // MARK: - Private
    
    enum HTTPMethod: String {
        case GET
        case POST
        case PUT
        case DELETE
    }
    
    private func createRequest(with url: URL?, type: HTTPMethod, completion: @escaping (URLRequest) -> Void) {
        AuthManager.shared.withValidToken { (token) in
            guard let apiUrl = url else { return }
            
            var request = URLRequest(url: apiUrl)
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.httpMethod = type.rawValue
            request.timeoutInterval = 30
            completion(request)
        }
    }
}
