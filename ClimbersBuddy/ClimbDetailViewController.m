//
//  ClimbDetailViewController.m
//  ClimbersBuddy
//
//  Created by Clark Barry on 8/30/12.
//  Copyright (c) 2012 CSHaus. All rights reserved.
//

#import "ClimbDetailViewController.h"
#import "ClimbInfo.h"


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
    _imageView.frame = CGRectMake(10, 10, _imageView.frame.size.width/2, _imageView.frame.size.height/2);
    [self.view addSubview:_imageView];
    _areaLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2+20, 10, self.view.frame.size.width/2, 100)];
    [_areaLabel setText:_climb.areaName];
    [self.view addSubview:_areaLabel];
    _descriptionLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, _imageView.frame.size.height+10, self.view.frame.size.width-20, 200)];
    _descriptionLabel.numberOfLines = 0;
    _descriptionLabel.adjustsFontSizeToFitWidth = YES;

    [_descriptionLabel setText:@"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus lorem enim, venenatis vitae condimentum egestas, mattis ut justo. In tempus, mauris at ullamcorper aliquam, orci lorem mollis eros, pharetra sagittis sem nisi a neque. Fusce ante neque, tempor at vulputate vitae, semper quis quam. Duis et leo nisi, sit amet congue elit. Quisque fringilla, massa sagittis commodo aliquam, enim massa facilisis leo, vel ornare lectus purus nec massa. Nullam purus sapien, interdum quis lacinia quis, laoreet vel tellus. Suspendisse quam risus, ultricies vitae interdum a, interdum ac magna. Maecenas nunc tellus, aliquet luctus dictum vitae, dictum consequat enim. Proin tempor lectus sed erat dapibus ut lobortis nibh eleifend. Vestibulum consequat egestas nibh, eu scelerisque justo interdum aliquam. Curabitur feugiat, risus nec posuere laoreet, nisi urna vehicula dolor, at imperdiet tellus mauris eu metus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Donec ac vehicula felis. Donec adipiscing, lectus eget eleifend ultrices, nisl ligula sagittis urna, a gravida urna erat semper dolor."];
    [self.view addSubview:_descriptionLabel];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
