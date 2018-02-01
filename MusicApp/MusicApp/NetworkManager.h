//
//  NetworkManager.h
//  MusicApp
//
//  Created by steve on 2018-02-01.
//  Copyright © 2018 steve. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Song;

@interface NetworkManager : NSObject
+ (void)fetchArtistNamed:(NSString *)name completionHandler:(void (^)(NSArray<Song*>*))completion;
@end
