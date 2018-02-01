  //
  //  Song.m
  //  MusicApp
  //
  //  Created by steve on 2018-02-01.
  //  Copyright © 2018 steve. All rights reserved.
  //

#import "Song.h"

@implementation Song
- (instancetype)initWithJSON:(NSDictionary *)json {
  if (self = [super init]) {
    _artistName = json[@"artistName"];
    _trackName = json[@"trackName"];
    _previewUrl = [NSURL URLWithString:json[@"previewUrl"]];
  }
  return self;
}

- (NSString *)description {
  return [NSString stringWithFormat:@"%@, %@", self.artistName, self.trackName];
}


@end
