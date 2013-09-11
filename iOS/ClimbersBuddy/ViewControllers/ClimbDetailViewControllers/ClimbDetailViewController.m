//
//  ClimbDetailViewController.m
//  ClimbersBuddy
//
//  Created by Clark Barry on 8/30/12.
//  Copyright (c) 2012 CSHaus. All rights reserved.
//

#import "ClimbDetailViewController.h"
#import "ClimbInfo.h"
#import "MyClimbsManager.h"
#import "ClimbersBuddyStyle.h"
#import "CommonDefines.h"
#import "LocationManager.h"
#import "ExpandableView.h"
#import "PointingViewController.h"
#import <MapKit/MapKit.h>
#import <QuartzCore/QuartzCore.h>

@interface ClimbDetailViewController ()
-(void)fetchImage;
-(NSArray *)getConstraints;
-(NSArray *)getConstraintsFor:(UIView *)smallView and:(UIView *)largeView withConstant:(CGFloat)constant;
-(NSLayoutConstraint *)xAlignmentFor:(UIView *)view;
-(void)tapRecognized:(UITapGestureRecognizer *)tap;
@end

@implementation ClimbDetailViewController

-(id)initWithClimb:(ClimbInfo *)climb{
    self = [super init];
    if(self){
        _climb = climb;
        self.title = @"Info";
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(!_climb.image){
        [self fetchImage];
    }
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    _imageView.originalFrame = _imageView.frame;
}

-(void)tapRecognized:(UITapGestureRecognizer *)tap{
    if(_imageView.expanded){
        _imageView.expanded = NO;
        [UIView animateWithDuration:.3
                         animations:^{
                             _imageView.frame = _imageView.originalFrame;
                         }];
    }else{
        _imageView.expanded = YES;

        [UIView animateWithDuration:.3
                         animations:^{
                             _imageView.frame = self.view.bounds;
                         }];
    }
}

-(void)fetchImage{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSString *imageUrlString = [_climb.imageName stringByReplacingOccurrencesOfString:@" "
                                                                           withString:@"%20"];
    NSURL *url = [NSURL URLWithString:imageUrlString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[[NSOperationQueue alloc]init]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if(error){
                                   dispatch_async(dispatch_get_main_queue(), ^{
                                       UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Could not connect"
                                                                                      message:@"Please check network connection"
                                                                                     delegate:nil
                                                                            cancelButtonTitle:@"Dismiss"
                                                                            otherButtonTitles: nil];
                                       [alert show];
                                   });
                               }else if(data){
                                   dispatch_async(dispatch_get_main_queue(), ^{
                                       UIImage *image = [UIImage imageWithData:data];
                                       [UIView transitionWithView:_imageView
                                                         duration:1.0f
                                                          options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                                                              _climb.image = image;
                                                              _imageView.image = image;
                                                          } completion:nil];
                                   });
                               }
                              [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:NO];
                           }];
    
}

-(void)loadView{
    [super loadView];
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    if ([self respondsToSelector:@selector(setExtendedLayoutIncludesOpaqueBars:)]) {
        self.extendedLayoutIncludesOpaqueBars = YES;
    }
    
    _tap = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                  action:@selector(tapRecognized:)];
    [self.view addGestureRecognizer:_tap];
    
    self.view.backgroundColor = BACKGROUND_COLOR;
    UIImage *climbImage = [UIImage imageNamed:placeHolderImageName];
    _imageView = [[ExpandableView alloc] initWithImage:climbImage];
    if(_climb.image){
        _imageView.highlightedImage = _climb.image;
        [_imageView setHighlighted:YES];
    }
    _imageView.layer.cornerRadius = 5.0f;
    _imageView.layer.masksToBounds = YES;
    [_imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:_imageView];

    _smallNameLabel = [ClimbersBuddyStyle getLabelWithSearchFormatting];
    [_smallNameLabel setText:@"Name:"];
    [_smallNameLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:_smallNameLabel];

    _smallTypeLabel = [ClimbersBuddyStyle getLabelWithSearchFormatting];
    [_smallTypeLabel setText:@"Type:"];
    [_smallTypeLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:_smallTypeLabel];
    
    _smallRouteLabel = [ClimbersBuddyStyle getLabelWithSearchFormatting];
    [_smallRouteLabel setText:@"Wall:"];
    [_smallRouteLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:_smallRouteLabel];
    
    _smallLocationLabel = [ClimbersBuddyStyle getLabelWithSearchFormatting];
    [_smallLocationLabel setText:@"Location:"];
    [_smallLocationLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:_smallLocationLabel];
    
    _nameLabel = [ClimbersBuddyStyle getClimbDetailLabel];
    [_nameLabel setText:_climb.name];
    [_nameLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:_nameLabel];
    
    _typeLabel = [ClimbersBuddyStyle getClimbDetailLabel];
    NSString *typeString = [NSString stringWithFormat:@"%@",[ClimbersBuddyStyle getStringForTypeEnum:_climb.type]];
    NSArray *difficulties = _climb.type == boulder ? [ClimbInfo getBoulderDifficulties] : [ClimbInfo getRopedDifficulties];
    NSString *difficultyString = [difficulties objectAtIndex:_climb.difficulty];
    if(difficultyString){
        typeString = [NSString stringWithFormat:@"%@, %@",typeString,difficultyString];
    }
    [_typeLabel setText:typeString];
    [_typeLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:_typeLabel];
    
    _wallLabel = [ClimbersBuddyStyle getClimbDetailLabel];
    [_wallLabel setText:_climb.wallName];
    [_wallLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:_wallLabel];
    
    _locationLabel = [ClimbersBuddyStyle getClimbDetailLabel];
    [_locationLabel setText:_climb.locationName];
    [_locationLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:_locationLabel];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(showActionSheet)];
    [self.navigationItem setRightBarButtonItem:rightItem animated:YES];
    
    _descriptionLabel = [[UITextView alloc]init];
    _descriptionLabel.font = [UIFont systemFontOfSize:15];
    [_descriptionLabel setEditable:NO];
    [_descriptionLabel setAllowsEditingTextAttributes:NO];
    [_descriptionLabel setText:_climb.description];
    _descriptionLabel.backgroundColor = BACKGROUND_COLOR;
    [_descriptionLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:_descriptionLabel];
    
    [self.view bringSubviewToFront:_imageView];
    
    [self.view addConstraints:[self getConstraints]];
}

-(NSArray *)getConstraints{
    NSMutableArray *constraints = [NSMutableArray arrayWithCapacity:5];
    
    NSLayoutConstraint *imageTopPadding = [NSLayoutConstraint constraintWithItem:_imageView
                                                                    attribute:NSLayoutAttributeTop
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:self.view
                                                                    attribute:NSLayoutAttributeTop
                                                                   multiplier:1.0
                                                                     constant:10];
    [constraints addObject:imageTopPadding];
    
    NSLayoutConstraint *imageSidePadding = [NSLayoutConstraint constraintWithItem:_imageView
                                                                        attribute:NSLayoutAttributeLeading
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.view
                                                                        attribute:NSLayoutAttributeLeading
                                                                       multiplier:1.0
                                                                         constant:10];
    [constraints addObject:imageSidePadding];
    
    NSLayoutConstraint *imageWidth = [NSLayoutConstraint constraintWithItem:_imageView
                                                                  attribute:NSLayoutAttributeWidth
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.view
                                                                  attribute:NSLayoutAttributeWidth
                                                                 multiplier:.5
                                                                   constant:-20];
    [constraints addObject:imageWidth];
    
    NSLayoutConstraint *imageHeight = [NSLayoutConstraint constraintWithItem:_imageView
                                                                   attribute:NSLayoutAttributeHeight
                                                                   relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                      toItem:_imageView
                                                                   attribute:NSLayoutAttributeWidth
                                                                  multiplier:1.0
                                                                    constant:0];
    [constraints addObject:imageHeight];
    
    NSLayoutConstraint *imageBottom = [NSLayoutConstraint constraintWithItem:_imageView
                                                                   attribute:NSLayoutAttributeBottom
                                                                   relatedBy:NSLayoutRelationLessThanOrEqual
                                                                      toItem:self.view
                                                                   attribute:NSLayoutAttributeCenterY
                                                                  multiplier:1.0
                                                                    constant:-5];
    [constraints addObject:imageBottom];
    
    [constraints addObject:[self xAlignmentFor:_smallNameLabel]];
    
    NSLayoutConstraint *smallNamePositionY = [NSLayoutConstraint constraintWithItem:_smallNameLabel
                                                                          attribute:NSLayoutAttributeTop
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:self.view
                                                                          attribute:NSLayoutAttributeTop
                                                                         multiplier:1.0
                                                                           constant:10];
    [constraints addObject:smallNamePositionY];
    
    [constraints addObjectsFromArray:[self getConstraintsFor:_smallNameLabel and:_nameLabel withConstant:1]];
    [constraints addObjectsFromArray:[self getConstraintsFor:_nameLabel and:_smallTypeLabel withConstant:5]];
    [constraints addObjectsFromArray:[self getConstraintsFor:_smallTypeLabel and:_typeLabel withConstant:1]];
    [constraints addObjectsFromArray:[self getConstraintsFor:_typeLabel and:_smallRouteLabel withConstant:5]];
    [constraints addObjectsFromArray:[self getConstraintsFor:_smallRouteLabel and:_wallLabel withConstant:1]];
    [constraints addObjectsFromArray:[self getConstraintsFor:_wallLabel and:_smallLocationLabel withConstant:5]];
    [constraints addObjectsFromArray:[self getConstraintsFor:_smallLocationLabel and:_locationLabel withConstant:1]];
    
    NSLayoutConstraint *descriptionX = [NSLayoutConstraint constraintWithItem:_descriptionLabel
                                                                    attribute:NSLayoutAttributeLeading
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:self.view
                                                                    attribute:NSLayoutAttributeLeading
                                                                   multiplier:1.0
                                                                     constant:10];
    [constraints addObject:descriptionX];
    
    NSLayoutConstraint *descriptionY = [NSLayoutConstraint constraintWithItem:_descriptionLabel
                                                                    attribute:NSLayoutAttributeTop
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:self.view
                                                                    attribute:NSLayoutAttributeCenterY
                                                                   multiplier:1.0
                                                                     constant:5];
    [constraints addObject:descriptionY];
    
    NSLayoutConstraint *descriptionWidth = [NSLayoutConstraint constraintWithItem:_descriptionLabel
                                                                        attribute:NSLayoutAttributeWidth
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.view
                                                                        attribute:NSLayoutAttributeWidth
                                                                       multiplier:1.0
                                                                         constant:-10];
    [constraints addObject:descriptionWidth];
    
    NSLayoutConstraint *descriptionHeight = [NSLayoutConstraint constraintWithItem:_descriptionLabel
                                                                         attribute:NSLayoutAttributeHeight
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self.view
                                                                         attribute:NSLayoutAttributeHeight
                                                                        multiplier:.5
                                                                          constant:-20];

    [constraints addObject:descriptionHeight];
    
    return constraints;
}

-(NSArray *)getConstraintsFor:(UIView *)smallView and:(UIView *)largeView withConstant:(CGFloat)constant{
    NSMutableArray *constraints = [NSMutableArray arrayWithCapacity:2];
    [constraints addObject:[NSLayoutConstraint constraintWithItem:largeView
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:smallView
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0
                                                         constant:constant]];
    [constraints addObject:[NSLayoutConstraint constraintWithItem:largeView
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:smallView
                                                        attribute:NSLayoutAttributeLeading
                                                       multiplier:1.0
                                                         constant:0]];
    return constraints;
}

-(NSLayoutConstraint *)xAlignmentFor:(UIView *)view{
    return [NSLayoutConstraint constraintWithItem:view
                                        attribute:NSLayoutAttributeLeading
                                        relatedBy:NSLayoutRelationEqual
                                           toItem:self.view
                                        attribute:NSLayoutAttributeCenterX
                                       multiplier:1.0
                                         constant:10];
}

-(void)showActionSheet{
    NSString *myClimbsString = [MyClimbsManager myClimbsContains:_climb] ? @"Remove from My Climbs" : @"Add to My Climbs";
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:@"Directions to Parking",@"Directions to Climb",myClimbsString, nil];
    [sheet showFromTabBar:self.tabBarController.tabBar];
}

-(void)getWalkingDirections{
    PointingViewController *compass = [[PointingViewController alloc] initWithTargetLocationCoordinate:CLLocationCoordinate2DMake([_climb.latitude doubleValue],[_climb.longitude doubleValue])];
    [self.navigationController pushViewController:compass animated:YES];
}

-(void)getDrivingDirections{
    CLLocation *current = [[LocationManager getInstance] getLocation];
    NSString *url = [ClimbersBuddyStyle directionsURLForStart:current.coordinate toFinish:CLLocationCoordinate2DMake([_climb.parkingLatitude doubleValue], [_climb.parkingLongitude doubleValue]) withWalking:NO];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            [self getDrivingDirections];
            break;
        case 1:
            [self getWalkingDirections];
            break;
        case 2:{
            NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
            if([buttonTitle rangeOfString:@"Remove" options:NSCaseInsensitiveSearch].location == NSNotFound){
                [self saveClimb];
            }else{
                [self removeClimb];
            }
            break;
        }
        default:
            break;
    }
    [actionSheet dismissWithClickedButtonIndex:buttonIndex animated:YES];
}

-(void)saveClimb{
    [MyClimbsManager addClimb:_climb];
}

-(void)removeClimb{
    [MyClimbsManager removeClimb:_climb];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
