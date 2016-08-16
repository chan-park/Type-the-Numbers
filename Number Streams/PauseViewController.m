//
//  PauseViewController.m
//  Number Streams
//
//  Created by Chan Hee Park on 6/5/14.
//  Copyright (c) 2014 Chan Park. All rights reserved.
//

#import "PauseViewController.h"

@interface PauseViewController ()
{
    SystemSoundID buttonSound;
}
@property (weak, nonatomic) IBOutlet UILabel *modeType;
@end

@implementation PauseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *buttonSoundFile = [[NSBundle mainBundle]pathForResource:@"transition" ofType:@"wav"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef) [NSURL fileURLWithPath:buttonSoundFile], &buttonSound);
    
    self.modeType.text = ((EditorViewController *)self.presentingViewController).mode.capitalizedString;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



- (IBAction)buttonPressed:(id)sender {
    AudioServicesPlaySystemSound(buttonSound);
    if ([((UIButton *) sender).titleLabel.text isEqualToString:@"resume"]){
        self.resumePressed = YES;
    } else if ([((UIButton *) sender).titleLabel.text isEqualToString:@"restart"]){
        self.resumePressed = NO;
    } else if ([((UIButton *) sender).titleLabel.text isEqualToString:@"exit"]) {
        // [(EditorViewController *)self.presentingViewController stopTimer];
    }
}

#pragma mark - iAd Delegate Methods
- (void)bannerViewDidLoadAd:(ADBannerView *)banner {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [banner setAlpha:1];
    [UIView commitAnimations];
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [banner setAlpha:0];
    [UIView commitAnimations];
}
@end
