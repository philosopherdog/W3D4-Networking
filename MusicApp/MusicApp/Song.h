//
//  Song.h
//  MusicApp
//
//  Created by steve on 2018-02-01.
//  Copyright © 2018 steve. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Song : NSObject
@property (nonatomic, readonly) NSString *artistName;
@property (nonatomic, readonly) NSString *trackName;
@property (nonatomic, readonly) NSURL *previewUrl;
- (instancetype)initWithJSON:(NSDictionary *)json;
@end
