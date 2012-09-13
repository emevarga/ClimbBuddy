//
//  ClimbDetailViewController.m
//  ClimbersBuddy
//
//  Created by Clark Barry on 8/30/12.
//  Copyright (c) 2012 CSHaus. All rights reserved.
//

#import "ClimbDetailViewController.h"
#import "ClimbInfo.h"

#import "ClimbersBuddyStyle.h"


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
    _imageView.frame = CGRectMake(10, 10, _imageView.frame.size.width/2-10, _imageView.frame.size.height/2-10);
    [self.view addSubview:_imageView];
    
    _nameLabel = [ClimbersBuddyStyle getClimbDetailLabel];
    [_nameLabel setText:_climb.name];
    CGSize textSize = [_nameLabel.text sizeWithFont:_nameLabel.font];
    _nameLabel.frame = CGRectMake(self.view.frame.size.width/2-10, 10, self.view.frame.size.width/2+10, textSize.height);
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
    typeRect.origin.y += 10+typeRect.size.height;
    
    _typeLabel.frame = typeRect;
    [self.view addSubview:_typeLabel];
    
    _wallLabel = [ClimbersBuddyStyle getClimbDetailLabel];
    CGRect wallFrame = _typeLabel.frame;
    wallFrame.origin.y += 10+wallFrame.size.height;
    _wallLabel.frame = wallFrame;
    [_wallLabel setText:[NSString stringWithFormat:@"%@, %@",_climb.wallName,_climb.locationName]];
    [self.view addSubview:_wallLabel];
    
    UIButton *directionsButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [directionsButton setTitle:@"Get Directions" forState:UIControlStateNormal];
    CGRect buttonFrame = wallFrame;
    buttonFrame.origin.y += wallFrame.size.height + 10;
    buttonFrame.size.width -= 10;
    buttonFrame.size.height = 30;
    directionsButton.frame = buttonFrame;
    [self.view addSubview:directionsButton];
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    buttonFrame.origin.y += buttonFrame.size.height + 10;
    addButton.frame = buttonFrame;
    [addButton setTitle:@"Add to MyClimbs" forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(addToMyClimbs) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addButton];
    
    _descriptionLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, _imageView.frame.size.height+10, self.view.frame.size.width-20, 200)];
    _descriptionLabel.numberOfLines = 0;
    _descriptionLabel.adjustsFontSizeToFitWidth = YES;
    [_descriptionLabel setText:_climb.description];
    [self.view addSubview:_descriptionLabel];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
