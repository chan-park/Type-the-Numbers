//
//  CongratulationViewController.m
//  Number Streams
//
//  Created by Chan Hee Park on 6/5/14.
//  Copyright (c) 2014 Chan Park. All rights reserved.
//

#import "CongratulationViewController.h"

@interface CongratulationViewController ()
{
    SystemSoundID buttonSound;
}
@property (weak, nonatomic) IBOutlet UILabel *bestScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *bestScore;
@property (weak, nonatomic) IBOutlet UILabel *modeType;
- (IBAction)buttonPressed:(id)sender;
- (IBAction)shareFacebook:(id)sender;
- (IBAction)shareTwitter:(id)sender;

@end

@implementation CongratulationViewController

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
    
    self.modeType.text = ((EditorViewController *)self.presentingViewController).mode;
    if ([((EditorViewController *)self.presentingViewController).mode isEqualToString: @"classic"]) {
        self.modeType.text = @"Classic";
        float highestScore = [[NSUserDefaults standardUserDefaults] floatForKey:@"classicHighScore"];
        
        if (highestScore == 0 || highestScore > self.time) {
            self.bestScoreLabel.hidden = NO;
            SystemSoundID applause;
            NSString *applauseSoundFile = [[NSBundle mainBundle]pathForResource:@"applause" ofType:@"wav"];
            AudioServicesCreateSystemSoundID((__bridge CFURLRef) [NSURL fileURLWithPath:applauseSoundFile], &applause);
            AudioServicesPlaySystemSound(applause);
            [[NSUserDefaults standardUserDefaults] setFloat:self.time forKey:@"classicHighScore"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            self.view.backgroundColor = [UIColor colorWithRed:197.0/255.0 green:179.0/255.0 blue:88.0/255.0 alpha:1.0];
        } else {
            
            self.bestScore.hidden = NO;
            self.bestScore.text = [NSString stringWithFormat:@"%.2f", highestScore];
            self.view.backgroundColor = [UIColor colorWithRed:179/255.0 green:255.0/255.0 blue:57.0/255.0 alpha:1.0];
        }
        self.score.text = [NSString stringWithFormat:@"%.2f", self.time];
        
    } else if ([((EditorViewController *)self.presentingViewController).mode isEqualToString: @"zen"]){
        self.modeType.text = @"Zen";
        NSInteger highestScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"zenHighScore"];
        
        if (highestScore < self.steps) {
            self.bestScoreLabel.hidden = NO;
            SystemSoundID applause;
            NSString *applauseSoundFile = [[NSBundle mainBundle]pathForResource:@"applause" ofType:@"wav"];
            AudioServicesCreateSystemSoundID((__bridge CFURLRef) [NSURL fileURLWithPath:applauseSoundFile], &applause);
            AudioServicesPlaySystemSound(applause);
            [[NSUserDefaults standardUserDefaults] setInteger:self.steps forKey:@"zenHighScore"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            self.view.backgroundColor = [UIColor colorWithRed:197.0/255.0 green:179.0/255.0 blue:88.0/255.0 alpha:1.0];
        } else {
            
            self.bestScore.hidden = NO;
            self.bestScore.text = [NSString stringWithFormat:@"%li", (long)highestScore];
            self.view.backgroundColor = [UIColor colorWithRed:179/255.0 green:255.0/255.0 blue:57.0/255.0 alpha:1.0];
        }
        self.score.text = [NSString stringWithFormat:@"%i", self.steps];
    } else if ([((EditorViewController *)self.presentingViewController).mode isEqualToString: @"reaction"]) {
        self.modeType.text = @"Reaction";
        NSInteger highestScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"reactionHighScore"];
        
        if (highestScore < self.steps) {
            self.bestScoreLabel.hidden = NO;
            SystemSoundID applause;
            NSString *applauseSoundFile = [[NSBundle mainBundle]pathForResource:@"applause" ofType:@"wav"];
            AudioServicesCreateSystemSoundID((__bridge CFURLRef) [NSURL fileURLWithPath:applauseSoundFile], &applause);
            AudioServicesPlaySystemSound(applause);
            [[NSUserDefaults standardUserDefaults] setInteger:self.steps forKey:@"reactionHighScore"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            self.view.backgroundColor = [UIColor colorWithRed:197.0/255.0 green:179.0/255.0 blue:88.0/255.0 alpha:1.0];
        } else {
            
            self.bestScore.hidden = NO;
            self.bestScore.text = [NSString stringWithFormat:@"%li", (long)highestScore];
            self.view.backgroundColor = [UIColor colorWithRed:179/255.0 green:255.0/255.0 blue:57.0/255.0 alpha:1.0];
        }
        self.score.text = [NSString stringWithFormat:@"%i", self.steps];
        
    }
    
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
}

- (IBAction)shareTwitter:(id)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        if ([self.modeType.text isEqualToString:@"Zen"]) {
            [tweetSheet setInitialText:[NSString stringWithFormat:@"Got %i for Zen mode on Type The Numbers! Amazing game!", self.steps]];
        } else if ([self.modeType.text isEqualToString:@"Reaction"]) {
            [tweetSheet setInitialText:[NSString stringWithFormat:@"Got %i for Reaction mode on Type the Numbers! Amazing game!", self.steps]];
        } else {
            [tweetSheet setInitialText:[NSString stringWithFormat:@"Got %0.2f for Classic mode on Type the Numbers! Amazing game!", self.time]];
        }
        
        [self presentViewController:tweetSheet
                           animated:YES
                         completion:nil];
    } else {
        NSLog(@"twitter isn't available");
    }
}

- (IBAction)shareFacebook:(id)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        SLComposeViewController *facebookPost = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        if ([self.modeType.text isEqualToString:@"Zen"]) {
            [facebookPost setInitialText:[NSString stringWithFormat:@"Got %i for Zen mode on Type The Numbers! Amazing game!", self.steps]];
        } else if ([self.modeType.text isEqualToString:@"Reaction"]) {
            [facebookPost setInitialText:[NSString stringWithFormat:@"Got %i for Reaction mode on Type the Numbers! Amazing game!", self.steps]];
        } else {
            [facebookPost setInitialText:[NSString stringWithFormat:@"Got %0.2f for Classic mode on Type the Numbers! Amazing game!", self.time]];
        }
        
        [self presentViewController:facebookPost
                           animated:YES
                         completion:nil];
    } else {
        NSLog(@"facebook isn't available");
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
