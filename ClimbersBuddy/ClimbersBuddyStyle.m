//
//  ClimbersBuddyStyle.m
//  ClimbersBuddy
//
//  Created by Clark Barry on 8/23/12.
//  Copyright (c) 2012 CSHaus. All rights reserved.
//

#import "ClimbersBuddyStyle.h"

#import <QuartzCore/QuartzCore.h>
@implementation ClimbersBuddyStyle

+(UILabel *)getLabelWithSearchFormatting{
    UILabel *searchLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    UIFont *searchFont = [UIFont boldSystemFontOfSize:11];
    [searchLabel setFont:searchFont];
    [searchLabel setTextColor:[UIColor darkGrayColor]];
    return searchLabel;
}

+(UILabel *)getClimbDetailLabel{
    UILabel *detailLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    UIFont *font = [UIFont boldSystemFontOfSize:18];
    [detailLabel setFont:font];
    [detailLabel setTextColor:[UIColor darkGrayColor]];    
    return detailLabel;
}

+(NSString *)getFillerDescriptionText{
    return @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus lorem enim, venenatis vitae condimentum egestas, mattis ut justo. In tempus, mauris at ullamcorper aliquam, orci lorem mollis eros, pharetra sagittis sem nisi a neque. Fusce ante neque, tempor at vulputate vitae, semper quis quam. Duis et leo nisi, sit amet congue elit. Quisque fringilla, massa sagittis commodo aliquam, enim massa facilisis leo, vel ornare lectus purus nec massa. Nullam purus sapien, interdum quis lacinia quis, laoreet vel tellus. Suspendisse quam risus, ultricies vitae interdum a, interdum ac magna. Maecenas nunc tellus, aliquet luctus dictum vitae, dictum consequat enim. Proin tempor lectus sed erat dapibus ut lobortis nibh eleifend. Vestibulum consequat egestas nibh, eu scelerisque justo interdum aliquam. Curabitur feugiat, risus nec posuere laoreet, nisi urna vehicula dolor, at imperdiet tellus mauris eu metus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Donec ac vehicula felis. Donec adipiscing, lectus eget eleifend ultrices, nisl ligula sagittis urna, a gravida urna erat semper dolor.";
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

@end
