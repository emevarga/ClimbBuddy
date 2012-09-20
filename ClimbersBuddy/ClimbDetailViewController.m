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

#define IMAGE_RECT CGRectMake(10,10,self.view.frame.size.width/2-20,self.view.frame.size.height/3-20)

@interface ClimbDetailViewController ()
-(void)addToMyClimbs;
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

-(void)addToMyClimbs{
    NSManagedObjectContext *context = [self managedObjectContext];
    
}

-(void)loadView{
    [super loadView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIImage *climbImage = [UIImage imageNamed:_climb.imageName];
    _imageView = [[UIImageView alloc] initWithImage:climbImage];
    _imageView.frame = IMAGE_RECT;
    [self.view addSubview:_imageView];
    
    _nameLabel = [ClimbersBuddyStyle getClimbDetailLabel];
    [_nameLabel setText:_climb.name];
    CGSize textSize = [_nameLabel.text sizeWithFont:_nameLabel.font];
    _nameLabel.frame = CGRectMake(self.view.frame.size.width/2 + 10, 10, self.view.frame.size.width/2-20, textSize.height);
    [self.view addSubview:_nameLabel];
    
    _typeLabel = [ClimbersBuddyStyle getClimbDetailLabel];
    NSString *typeString = [NSString stringWithFormat:@"%@",[ClimbersBuddyStyle getStringForTypeEnum:[_climb.type intValue]]];
    NSArray *difficulties = [_climb.type intValue] == boulder ? [ClimbInfo getBoulderDifficulties] : [ClimbInfo getRopedDifficulties];
    NSString *difficultyString = [difficulties objectAtIndex:[_climb.difficulty intValue]];
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
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    buttonFrame.origin.y += buttonFrame.size.height + 10;
    addButton.frame = buttonFrame;
    [addButton setTitle:@"Add to MyClimbs" forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(addToMyClimbs) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addButton];
    
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(showActionSheet)];
    [self.navigationItem setRightBarButtonItem:rightItem animated:YES];
    
    _descriptionLabel = [[UITextView alloc]initWithFrame:CGRectMake(10, _imageView.frame.origin.y+_imageView.frame.size.height+10, self.view.frame.size.width-20, 200)];
    _descriptionLabel.font = [UIFont systemFontOfSize:15];
    _descriptionLabel.editable = NO;
    [_descriptionLabel setText:_climb.description];
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
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Climb Actions"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:@"Get Directions",myClimbsString, nil];
    [sheet showFromTabBar:self.tabBarController.tabBar];
}

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
