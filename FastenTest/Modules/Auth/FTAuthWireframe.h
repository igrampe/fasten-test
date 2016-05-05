//
//  FTAuthWireframe.h
//  FastenTest
//
//  Created by Semyon Belokovsky on 29/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FTWireframe.h"

@class FTAuthWireframe;

@protocol FTAuthWireframeOutput <NSObject>

- (void)authWireframeDidFinish:(FTAuthWireframe *)wireframe;

@end

@interface FTAuthWireframe : NSObject <FTWireframeProtocol>

@property (nonatomic, weak) id<FTAuthWireframeOutput> output;

@end
