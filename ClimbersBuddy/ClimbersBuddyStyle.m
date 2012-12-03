//
//  ClimbersBuddyStyle.m
//  ClimbersBuddy
//
//  Created by Clark Barry on 8/23/12.
//  Copyright (c) 2012 CSHaus. All rights reserved.
//

#import "ClimbersBuddyStyle.h"
#import <QuartzCore/QuartzCore.h>
#import "ToggleSegmentedControl.h"
#import "CommonDefines.h"
#import "RangeSlider.h"

@interface ClimbersBuddyStyle (Internal)
+(UIImage *)imageForColor:(UIColor *)color;
+(CALayer *)getGradientForLayer:(CALayer *)layer;
@end
@implementation ClimbersBuddyStyle

+(UILabel *)getLabelWithSearchFormatting{
    UILabel *searchLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    UIFont *searchFont = [UIFont boldSystemFontOfSize:11];
    searchLabel.backgroundColor = BACKGROUND_COLOR;
    [searchLabel setFont:searchFont];
    [searchLabel setTextColor:[UIColor darkGrayColor]];
    return searchLabel;
}

+(UILabel *)getClimbDetailLabel{
    UILabel *detailLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    UIFont *font = [UIFont boldSystemFontOfSize:18];
    detailLabel.backgroundColor = BACKGROUND_COLOR;
    [detailLabel setFont:font];
    [detailLabel setTextColor:[UIColor darkGrayColor]];    
    return detailLabel;
}

+(NSString *)getFillerDescriptionText{
    return @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus lorem enim, venenatis vitae condimentum egestas, mattis ut justo. In tempus, mauris at ullamcorper aliquam, orci lorem mollis eros, pharetra sagittis sem nisi a neque. Fusce ante neque, tempor at vulputate vitae, semper quis quam. Duis et leo nisi, sit amet congue elit. Quisque fringilla, massa sagittis commodo aliquam, enim massa facilisis leo, vel ornare lectus purus nec massa. Nullam purus sapien, interdum quis lacinia quis, laoreet vel tellus. Suspendisse quam risus, ultricies vitae interdum a, interdum ac magna. Maecenas nunc tellus, aliquet luctus dictum vitae, dictum consequat enim. Proin tempor lectus sed erat dapibus ut lobortis nibh eleifend. Vestibulum consequat egestas nibh, eu scelerisque justo interdum aliquam. Curabitur feugiat, risus nec posuere laoreet, nisi urna vehicula dolor, at imperdiet tellus mauris eu metus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Donec ac vehicula felis. Donec adipiscing, lectus eget eleifend ultrices, nisl ligula sagittis urna, a gravida urna erat semper dolor.";
}



+(NSArray *)getMiles{
    return @[[NSNumber numberWithInt:5],[NSNumber numberWithInt:25],[NSNumber numberWithInt:50],[NSNumber numberWithInt:100]];
}

+(NSInteger)milesForSegment:(NSUInteger)index{
    return [(NSNumber *)[[[self class] getMiles] objectAtIndex:index]integerValue];
}

+(ClimbType)getTypeForIndex:(NSUInteger)index{
    index += 10;
    return index;
}

+(ClimbType)getEnumForString:(NSString *)string{
    ClimbType type;
    if([string isEqualToString:@"Boulder"]){
        type = boulder;
    }else if([string isEqualToString:@"Trad"]){
        type = trad;
    }else if([string isEqualToString:@"Top Rope"]){
        type = topRope;
    }else if([string isEqualToString:@"Lead"]){
        type = lead;
    }
    return type;
}

+(NSString *)getStringForTypeEnum:(ClimbType)type{
    NSString *string = nil;
    switch (type) {
        case (boulder):
            string = @"Boulder";
            break;
        case (trad):
            string = @"Trad.";
            break;
        case (lead):
            string = @"Lead";
            break;
        case (topRope):
            string = @"Top Rope";
            break;
        default:
            break;
    }
    return string;
}

+(UIImage *)imageForColor:(UIColor *)color{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+(CALayer *)getGradientForLayer:(CALayer *)layer{
    CALayer *backgroundLayer = [CALayer layer];
    backgroundLayer.cornerRadius = layer.cornerRadius;
    backgroundLayer.masksToBounds = layer.masksToBounds;
    backgroundLayer.frame = layer.bounds;
    
    CAGradientLayer *gradeientLayer = [CAGradientLayer layer];
    gradeientLayer.frame = layer.bounds;
    gradeientLayer.colors = @[(id)[[UIColor colorWithWhite:1 alpha:.1]CGColor],(id)[[UIColor colorWithWhite:.8 alpha:.2]CGColor],(id)[[UIColor colorWithWhite:.75 alpha:.02]CGColor],(id)[[UIColor colorWithWhite:.5 alpha:.1]CGColor]];
    gradeientLayer.locations = @[[NSNumber numberWithFloat:0],[NSNumber numberWithFloat:.5],[NSNumber numberWithFloat:.5],[NSNumber numberWithFloat:1]];
    [backgroundLayer addSublayer:gradeientLayer];
    return backgroundLayer;
}

+(RangeSlider *)getRangeSlider:(CGRect)rect{
    RangeSlider *rangeSilder = [[RangeSlider alloc] initWithFrame:rect];
    [rangeSilder setTrackBackgroundColor:SEARCH_CONTROL_TEXT_COLOR];
    [rangeSilder setTrackHighlightColor:SEARCH_CONTROL_COLOR];
    [rangeSilder setThumbColor:SEARCH_CONTROL_HIGHLIGHTED_COLOR];
    return rangeSilder;
}

+(UIButton *)getButtonForSearch{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"Search" forState:UIControlStateNormal];
    [button setTitleColor:SEARCH_CONTROL_TEXT_COLOR forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightTextColor] forState:UIControlStateHighlighted];
    [button setBackgroundImage:[[self class]imageForColor:SEARCH_CONTROL_HIGHLIGHTED_COLOR] forState:UIControlStateHighlighted];
    button.backgroundColor = SEARCH_CONTROL_COLOR;
    [button.layer setMasksToBounds:YES];
    button.layer.borderWidth = .5;
    button.layer.borderColor = [[UIColor darkGrayColor]CGColor];
    button.layer.cornerRadius = 7;
    
    [button.layer insertSublayer:[[self class]getGradientForLayer:button.layer]atIndex:0];
    
    return button;
}


+(UISegmentedControl *)getSegmentedControlWithItems:(NSArray *)items withToggle:(BOOL)toggle{
    UISegmentedControl *control = toggle ? [[ToggleSegmentedControl alloc] initWithItems:items]: [[UISegmentedControl alloc]initWithItems:items];
    control.segmentedControlStyle = UISegmentedControlStyleBar;
    [control setTitleTextAttributes:@{ UITextAttributeFont : [UIFont systemFontOfSize:13],UITextAttributeTextColor: SEARCH_CONTROL_TEXT_COLOR}
                                   forState:UIControlStateNormal];
    control.tintColor = [UIColor lightGrayColor];
    return control;
}

+(NSString *)directionsURLForStart:(CLLocationCoordinate2D)start toFinish:(CLLocationCoordinate2D)finish withWalking:(BOOL)walking{
    NSString *url =[NSString stringWithFormat:@"http://maps.google.com/maps?saddr=%lf,%lf&daddr=%lf,%lf",start.latitude,start.longitude,finish.latitude,finish.longitude];
    if(walking){
        url = [url stringByAppendingString:@"&dirflg=w"];
    }
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return url;
}


@end
