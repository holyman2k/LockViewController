//
//  UnlockViewController.h
//  BabeScene
//
//  Created by Charlie Wu on 6/06/13.
//  Copyright (c) 2013 Charlie Wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LockViewController : UIViewController
@property (strong, nonatomic) NSString *unlockCode;

+ (void)presentWithViewController:(UIViewController *)viewController withUnlockKey:(NSString *)unlockCode;
@end
