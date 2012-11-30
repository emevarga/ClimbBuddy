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
#import <MapKit/MapKit.h>
#import <QuartzCore/QuartzCore.h>

#define IMAGE_RECT CGRectMake(10,10,self.view.frame.size.width/2-20,self.view.frame.size.height/3-20)

@interface ClimbDetailViewController ()
-(void)positionLabels:(NSArray *)views inRect:(CGRect)rect;
-(void)fetchImage;
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

-(void)fetchImage{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSURL *url = [NSURL URLWithString:_climb.imageName];
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
    
    self.view.backgroundColor = BACKGROUND_COLOR;
    UIImage *climbImage = [UIImage imageNamed:placeHolderImageName];
    _imageView = [[UIImageView alloc] initWithImage:climbImage];
    if(_climb.image){
        _imageView.highlightedImage = _climb.image;
        [_imageView setHighlighted:YES];
    }
    _imageView.layer.cornerRadius = 5.0f;
    _imageView.layer.masksToBounds = YES;
    _imageView.frame = IMAGE_RECT;
    [self.view addSubview:_imageView];
    
    _nameLabel = [ClimbersBuddyStyle getClimbDetailLabel];
    [_nameLabel setText:_climb.name];
    CGSize textSize = [_nameLabel.text sizeWithFont:_nameLabel.font];
    _nameLabel.frame = CGRectMake(self.view.frame.size.width/2 + 10, 10, self.view.frame.size.width/2-20, textSize.height);
    [self.view addSubview:_nameLabel];
    
    _typeLabel = [ClimbersBuddyStyle getClimbDetailLabel];
    NSString *typeString = [NSString stringWithFormat:@"%@",[ClimbersBuddyStyle getStringForTypeEnum:_climb.type]];
    NSArray *difficulties = _climb.type == boulder ? [ClimbInfo getBoulderDifficulties] : [ClimbInfo getRopedDifficulties];
    NSString *difficultyString = [difficulties objectAtIndex:_climb.difficulty];
    if(difficultyString){
        typeString = [NSString stringWithFormat:@"%@, %@",typeString,difficultyString];
    }
    [_typeLabel setText:typeString];
    
    CGRect typeRect = _nameLabel.frame;
    _typeLabel.frame = typeRect;
    [self.view addSubview:_typeLabel];
    
    _wallLabel = [ClimbersBuddyStyle getClimbDetailLabel];
    CGRect wallFrame = _typeLabel.frame;
    _wallLabel.frame = wallFrame;
    [_wallLabel setText:_climb.wallName];
    [self.view addSubview:_wallLabel];
    
    _locationLabel = [ClimbersBuddyStyle getClimbDetailLabel];
    CGRect locationFrame = _wallLabel.frame;
    _locationLabel.frame = locationFrame;
    [_locationLabel setText:_climb.locationName];
    [self.view addSubview:_locationLabel];
    
    CGRect labelRect = CGRectMake(self.view.frame.size.width/2, _imageView.frame.origin.y, self.view.frame.size.width/2, _imageView.frame.size.height);
    NSArray *labels = [NSArray arrayWithObjects:_nameLabel,_typeLabel,_wallLabel,_locationLabel, nil];
    [self positionLabels:labels inRect:labelRect];
    
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(showActionSheet)];
    [self.navigationItem setRightBarButtonItem:rightItem animated:YES];
    
    _descriptionLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, _imageView.frame.origin.y+_imageView.frame.size.height+10, self.view.frame.size.width-20, 200)];
    [_descriptionLabel setNumberOfLines:0];
    [_descriptionLabel setLineBreakMode:NSLineBreakByWordWrapping];
    _descriptionLabel.font = [UIFont systemFontOfSize:15];
    [_descriptionLabel setText:_climb.description];
    _descriptionLabel.backgroundColor = BACKGROUND_COLOR;
    [self.view addSubview:_descriptionLabel];
}

-(void)positionLabels:(NSArray *)views inRect:(CGRect)rect{
    CGPoint origin = CGPointMake(rect.origin.x+MYCLIMBS_PADDING, rect.origin.y-MYCLIMBS_PADDING/2);
    for(UIView *view in views){
        origin.y += MYCLIMBS_PADDING;
        CGRect viewFrame = view.frame;
        viewFrame.origin = origin;
        view.frame = viewFrame;
        origin.y += view.frame.size.height;

    }
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
    CLLocation *current = [[LocationManager getInstance] getLocation];
    NSString *url = [ClimbersBuddyStyle directionsURLForStart:current.coordinate toFinish:CLLocationCoordinate2DMake([_climb.latitude doubleValue], [_climb.longitude doubleValue]) withWalking:YES];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
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
