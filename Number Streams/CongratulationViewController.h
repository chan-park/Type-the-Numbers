//
//  CongratulationViewController.h
//  Number Streams
//
//  Created by Chan Hee Park on 6/5/14.
//  Copyright (c) 2014 Chan Park. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import <Social/Social.h>
#import "EditorViewController.h"
@import AudioToolbox;
@interface CongratulationViewController : UIViewController <ADBannerViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *score;
@property int steps;
@property float time;

@end
