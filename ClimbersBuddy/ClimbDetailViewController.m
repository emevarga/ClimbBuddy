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

@end

@implementation ClimbDetailViewController

-(id)initWithClimb:(ClimbInfo *)climb{
    self = [super init];
    if(self){
        _climb = climb;
        self.title = _climb.name;
    }
    return self;
}

-(void)loadView{
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    UIImage *climbImage = [UIImage imageNamed:_climb.imageName];
    _imageView = [[UIImageView alloc] initWithImage:climbImage];
    _imageView.frame = CGRectMake(10, 10, _imageView.frame.size.width/2-10, _imageView.frame.size.height/2-10);
    [self.view addSubview:_imageView];
    _typeLabel = [ClimbersBuddyStyle getClimbDetailLabel];
    _typeLabel.frame = CGRectMake(self.view.frame.size.width/2, 10, self.view.frame.size.width/2, 40);
    NSString *typeString = [NSString stringWithFormat:@"%@",[ClimbersBuddyStyle getStringForTypeEnum:_climb.type]];
    NSArray *difficulties = _climb.type == boulder ? [ClimbInfo getBoulderDifficulties] : [ClimbInfo getRopedDifficulties];
    
    NSString *difficultyString = [difficulties objectAtIndex:_climb.difficulty];
    if(difficultyString){
        typeString = [NSString stringWithFormat:@"%@, %@",typeString,difficultyString];
    }
    [_typeLabel setText:typeString];
    [self.view addSubview:_typeLabel];
    
    _wallLabel = [ClimbersBuddyStyle getClimbDetailLabel];
    CGRect wallFrame = _typeLabel.frame;
    wallFrame.origin.y += 10+wallFrame.size.height;
    [_wallLabel setText:[NSString stringWithFormat:@"%@, %@",_climb.wallName,_climb.locationName]];
    [self.view addSubview:_wallLabel];
    
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
