//
//  APLPageControl.m
//  Client
//
//  Created by Semyon Belokovsky on 24/10/15.
//  Copyright © 2015 App Plus. All rights reserved.
//

#import "APLPageControl.h"

static CGFloat APLPageControlDefaultSpace = 8;
static CGFloat APLPageControlDefaultImageWidth = 7;

@interface APLPageControl ()

@property (nonatomic) UIImage *pageImage;
@property (nonatomic) UIImage *currentPageImage;

@property NSMutableDictionary *pageImages;
@property NSMutableDictionary *currentPageImages;

@property NSMutableArray *pages;

@end

@implementation APLPageControl

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.pages = [NSMutableArray new];
    _currentPage = 0;
    _space = APLPageControlDefaultSpace;
    _imageWidth = 7;
    _numberOfPages = APLPageControlDefaultImageWidth;
    self.currentPageImages = [NSMutableDictionary new];
    self.pageImages = [NSMutableDictionary new];
    [self setupSubviews];
}

- (void)setupSubviews {
    for (UIImageView *v in self.pages) {
        [v removeFromSuperview];
    }
    [self.pages removeAllObjects];
    for (NSInteger i = 0; i < self.numberOfPages; i++) {
        UIImageView *v = [UIImageView new];
        NSNumber *key = [NSNumber numberWithInteger:i];
        UIImage *image = [self.pageImages objectForKey:key];
        if (image) {
            [v setImage:image];
        } else if (self.pageImage) {
            [v setImage:self.pageImage];
        }
        image = [self.currentPageImages objectForKey:key];
        if (image) {
            [v setHighlightedImage:image];
        } else if (self.pageImage) {
            [v setHighlightedImage:self.currentPageImage];
        }
        [self addSubview:v];
        [self.pages addObject:v];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat pagesWidth = self.imageWidth*self.pages.count+self.space*(self.pages.count-1);
    CGFloat offsetX = (self.bounds.size.width-pagesWidth)/2;
    for (NSUInteger i = 0; i < self.pages.count; i++) {
        UIImageView *v = [self.pages objectAtIndex:i];
        v.frame = CGRectMake(offsetX+i*(self.imageWidth+self.space), (self.bounds.size.height-v.image.size.height)/2, self.imageWidth, v.image.size.height);
    }
}

- (void)setPageImage:(UIImage *)pageImage {
    _pageImage = pageImage;
    [self setupSubviews];
}

- (void)setCurrentPageImage:(UIImage *)pageImage {
    _currentPageImage = pageImage;
    [self setupSubviews];
    if (self.pages.count > (NSUInteger)_currentPage) {
        UIImageView *v = [self.pages objectAtIndex:(NSUInteger)_currentPage];
        v.highlighted = YES;
    }
}

- (void)setImage:(UIImage *)image forPage:(NSInteger)page {
    if (self.pages.count > (NSUInteger)page) {
        UIImageView *imgView = [self.pages objectAtIndex:(NSUInteger)page];
        [imgView setImage:image];
    }
    NSNumber *key = [NSNumber numberWithInteger:page];
    if (image) {
        [self.pageImages setObject:image forKey:key];
    } else {
        [self.pageImages removeObjectForKey:key];
    }
    [self layoutSubviews];
}

- (void)setCurrentImage:(UIImage *)image forPage:(NSInteger)page {
    if (self.pages.count > (NSUInteger)page) {
        UIImageView *imgView = [self.pages objectAtIndex:(NSUInteger)page];
        [imgView setHighlightedImage:image];
    }
    NSNumber *key = [NSNumber numberWithInteger:page];
    if (image) {
        [self.currentPageImages setObject:image forKey:key];
    } else {
        [self.currentPageImages removeObjectForKey:key];
    }
    if (self.pages.count > (NSUInteger)_currentPage) {
        UIImageView *v = [self.pages objectAtIndex:(NSUInteger)_currentPage];
        v.highlighted = YES;
    }
    [self layoutSubviews];
}

- (void)setCurrentPage:(NSInteger)currentPage {
    if (self.pages.count > (NSUInteger)_currentPage) {
        UIImageView *v = [self.pages objectAtIndex:(NSUInteger)_currentPage];
        v.highlighted = NO;
    }
    _currentPage = currentPage;
    if (self.pages.count > (NSUInteger)_currentPage) {
        UIImageView *v = [self.pages objectAtIndex:(NSUInteger)_currentPage];
        v.highlighted = YES;
    }
}

- (void)setNumberOfPages:(NSInteger)numberOfPages {
    _numberOfPages = numberOfPages;
    [self setupSubviews];
    if (self.pages.count > (NSUInteger)_currentPage) {
        UIImageView *v = [self.pages objectAtIndex:(NSUInteger)_currentPage];
        v.highlighted = YES;
    }
    [self layoutSubviews];
}

- (void)setSpace:(CGFloat)space {
    _space = space;
    [self layoutSubviews];
}

- (void)setImageWidth:(CGFloat)imageWidth {
    _imageWidth = imageWidth;
    [self layoutSubviews];
}

@end
