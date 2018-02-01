  //
  //  ViewController.m
  //  MusicApp
  //
  //  Created by steve on 2018-02-01.
  //  Copyright © 2018 steve. All rights reserved.
  //

#import "ViewController.h"
#import "Song.h"
#import "NetworkManager.h"

@interface ViewController ()
@property (nonatomic) NSArray<Song *> *songs;
@end

@implementation ViewController

- (void)setSongs:(NSArray<Song *> *)songs {
  // update the UI
  _songs = songs;
  [self updateUI];
}

- (void)updateUI {
  
//  NSOperationQueue *mq = [NSOperationQueue mainQueue];
//  mq addOperationWithBlock:^{
//
//  }
  
  dispatch_async(dispatch_get_main_queue(), ^{
    // access songs here and update the interface
    NSLog(@"%d: songs: %@", __LINE__, self.songs);
  });
}

- (void)viewDidLoad {
  [super viewDidLoad];
//  [self fetchArtistNamed:@"Taylor Swift"];
  [NetworkManager fetchArtistNamed:@"Taylor Swift" completionHandler:^void(NSArray<Song *> * songs) {
    self.songs = songs;
  }];
  
}



















@end
