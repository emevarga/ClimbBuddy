//
//  MyClimbsDetailViewController.m
//  ClimbersBuddy
//
//  Created by Clark Barry on 9/17/12.
//  Copyright (c) 2012 CSHaus. All rights reserved.
//

#import "MyClimbsDetailViewController.h"
#import "MyClimbsManager.h"

@interface MyClimbsDetailViewController ()

@end

@implementation MyClimbsDetailViewController

-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            //get directions
            break;
        case 1:{
            NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
            if([buttonTitle rangeOfString:@"Remove" options:NSCaseInsensitiveSearch].location == NSNotFound){
                [self saveClimb];
            }else{
                [self removeClimb];
                [self.navigationController popViewControllerAnimated:YES];
            }
            break;
        }
        default:
            break;
    }
    [actionSheet dismissWithClickedButtonIndex:buttonIndex animated:YES];
}



@end
