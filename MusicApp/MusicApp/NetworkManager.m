//
//  NetworkManager.m
//  MusicApp
//
//  Created by steve on 2018-02-01.
//  Copyright © 2018 steve. All rights reserved.
//

#import "NetworkManager.h"
#import "Song.h"

@implementation NetworkManager

+ (void)fetchArtistNamed:(NSString *)name completionHandler:(void (^)(NSArray<Song*>*))completion {
    // create configuration
  NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
  configuration.waitsForConnectivity = YES;
  configuration.allowsCellularAccess = NO;
    // create session
  NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    // create task
  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[self createURLWithArtistName:name]];
  request.HTTPMethod = @"GET";
  [request addValue:@"application/json" forHTTPHeaderField:@"content-type"];
  
  NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    
    if (error) {
      NSLog(@"%@", error.localizedDescription);
      return;
    }
    
    NSInteger statusCode = ((NSHTTPURLResponse *) response).statusCode;
    if (statusCode != 200) {
      NSLog(@"%d: %@", __LINE__, @(statusCode));
      return;
    }
    
    if (!data) {
      NSLog(@"where's our data!");
      return;
    }
    NSError *jsonError;
    NSArray<NSDictionary *>*results = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError][@"results"];
    
    
    NSMutableArray *songs = [NSMutableArray arrayWithCapacity:results.count];
    
    for (NSDictionary *result in results) {
      [songs addObject:[[Song alloc]initWithJSON:result]];
    }
    
    
    completion(songs);
    [session invalidateAndCancel];
    
  }];
  [task resume];
}

+ (NSURL *)createURLWithArtistName:(NSString *)name {
  NSURLComponents *components = [NSURLComponents componentsWithString:@"https://itunes.apple.com/search"];
  NSURLQueryItem *media = [NSURLQueryItem queryItemWithName:@"media" value:@"music"];
  NSURLQueryItem *entity = [NSURLQueryItem queryItemWithName:@"entity" value:@"song"];
  NSURLQueryItem *term = [NSURLQueryItem queryItemWithName:@"term" value:name];
  
  components.queryItems = @[media, entity, term];
  return components.URL;
}
@end
