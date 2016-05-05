//
//  NSString+Attributing.m
//  Client
//
//  Created by Semyon Belokovsky on 24/10/15.
//  Copyright © 2015 App Plus. All rights reserved.
//

#import "NSString+Attributing.h"

@implementation NSString (Attributing)

+ (NSAttributedString *)attrubutedStringWithLineSpace:(CGFloat)lineSpace
                                                 font:(UIFont *)font
                                            charSpace:(CGFloat)charSpace
                                                color:(UIColor *)color
                                            alignment:(NSTextAlignment)alignment
                                                value:(NSString *)value
{
    NSAttributedString *aStr;
    if (value) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
        paragraphStyle.maximumLineHeight = lineSpace;
        paragraphStyle.alignment = alignment;
        NSDictionary *attrs = @{NSForegroundColorAttributeName: color,
                                NSFontAttributeName: font,
                                NSParagraphStyleAttributeName: paragraphStyle,
                                NSKernAttributeName: @(charSpace)};
        aStr = [[NSMutableAttributedString alloc] initWithString:value
                                                      attributes:attrs];
    }
    return aStr;
}

- (NSAttributedString *)attrubutedStringWithLineSpace:(CGFloat)lineSpace
                                                 font:(UIFont *)font
                                            charSpace:(CGFloat)charSpace
                                                color:(UIColor *)color
                                            alignment:(NSTextAlignment)alignment
{
    NSAttributedString *aStr = [NSString attrubutedStringWithLineSpace:lineSpace
                                                                  font:font
                                                             charSpace:charSpace
                                                                 color:color
                                                             alignment:alignment
                                                                 value:self];
    return aStr;
}

@end