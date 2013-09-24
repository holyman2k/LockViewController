//
//  UnlockViewController.m
//  BabeScene
//
//  Created by Charlie Wu on 6/06/13.
//  Copyright (c) 2013 Charlie Wu. All rights reserved.
//

#import "LockViewController.h"


@interface LockViewController ()
@property (strong, nonatomic) NSString *userInput;
@end

@implementation LockViewController

static id controller;

+ (void)presentWithViewController:(UIViewController *)viewController withUnlockKey:(NSString *)unlockCode;
{
    if (controller) {
        return;
    }
    UIViewController *presentingController = viewController;
    
    if ([[UIDevice currentDevice].systemVersion floatValue] < 6) {
        while (presentingController.presentedViewController){
            presentingController = presentingController.presentedViewController;
        }
    } else {        
        while (presentingController.presentedViewController){
            presentingController = presentingController.presentedViewController;
        }
    }
    
    if ([presentingController isKindOfClass:[UINavigationController class]]){
        presentingController = [(UINavigationController *)presentingController topViewController];
    }
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        controller = [[[NSBundle mainBundle] loadNibNamed:@"LockView_iPad" owner:self options:nil] lastObject];
    } else {
        controller = [[[NSBundle mainBundle] loadNibNamed:@"LockView_iPhone" owner:self options:nil] lastObject];
        
    }
    [controller setUnlockCode:unlockCode];
    [presentingController presentViewController:controller animated:NO completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.userInput = @"";
}

- (IBAction)numberKeyPress:(UIButton *)sender
{
    self.userInput = [self.userInput stringByAppendingString:sender.titleLabel.text];
    int keyLength = self.unlockCode.length;
    int from = self.userInput.length > keyLength ? self.userInput.length - keyLength : 0;
    int length = self.userInput.length > keyLength ? keyLength : self.userInput.length;
    NSString *key =[self.userInput substringWithRange:NSMakeRange(from, length)];
    NSLog(@"key %@", key);
    if ([key isEqualToString:self.unlockCode]){
        [self.presentedViewController dismissViewControllerAnimated:NO completion:nil];
        controller = nil;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation) && UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        return  NO;
    }
    return YES;
}

- (BOOL)shouldAutorotate
{
    if (self.interfaceOrientation == UIInterfaceOrientationPortrait && UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        return NO;
    }
    return YES;
}

@end
