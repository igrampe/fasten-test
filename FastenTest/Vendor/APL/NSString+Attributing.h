//
//  NSString+Attributing.h
//  Client
//
//  Created by Semyon Belokovsky on 24/10/15.
//  Copyright © 2015 App Plus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (Attributing)

+ (NSAttributedString *)attrubutedStringWithLineSpace:(CGFloat)lineSpace
                                                 font:(UIFont *)font
                                            charSpace:(CGFloat)charSpace
                                                color:(UIColor *)color
                                            alignment:(NSTextAlignment)alignment
                                                value:(NSString *)value;

- (NSAttributedString *)attrubutedStringWithLineSpace:(CGFloat)lineSpace
                                                 font:(UIFont *)font
                                            charSpace:(CGFloat)charSpace
                                                color:(UIColor *)color
                                            alignment:(NSTextAlignment)alignment;

@end