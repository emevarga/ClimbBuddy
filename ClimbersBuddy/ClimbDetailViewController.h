//
//  ClimbDetailViewController.h
//  ClimbersBuddy
//
//  Created by Clark Barry on 8/30/12.
//  Copyright (c) 2012 CSHaus. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ClimbInfo;

@interface ClimbDetailViewController : UIViewController<UIActionSheetDelegate>{
    ClimbInfo *_climb;
    UIImageView *_imageView;
    UILabel *_smallNameLabel;
    UILabel *_smallTypeLabel;
    UILabel *_smallRouteLabel;
    UILabel *_smallLocationLabel;
    UILabel *_nameLabel;
    UILabel *_typeLabel;
    UILabel *_wallLabel;
    UILabel *_locationLabel;
    UITextView *_descriptionLabel;
}

-(id)initWithClimb:(ClimbInfo *)climb;
-(void)saveClimb;
-(void)removeClimb;
-(void)showActionSheet;
-(void)getDrivingDirections;
-(void)getWalkingDirections;
@end
