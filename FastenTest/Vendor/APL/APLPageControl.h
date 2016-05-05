//
//  APLPageControl.h
//  Client
//
//  Created by Semyon Belokovsky on 24/10/15.
//  Copyright © 2015 App Plus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface APLPageControl : UIView

@property (nonatomic) NSInteger numberOfPages;
@property (nonatomic) NSInteger currentPage;
@property (nonatomic) CGFloat space;
@property (nonatomic) CGFloat imageWidth;

- (void)setPageImage:(UIImage *)pageImage;
- (void)setCurrentPageImage:(UIImage *)pageImage;

- (void)setImage:(UIImage *)image forPage:(NSInteger)page;
- (void)setCurrentImage:(UIImage *)image forPage:(NSInteger)page;

@end
