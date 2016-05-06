//
//  FTStatusWireframe.h
//  FastenTest
//
//  Created by Semyon Belokovsky on 06/05/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FTWireframe.h"

@interface FTStatusWireframe : NSObject <FTWireframeProtocol>

@property (nonatomic, assign) BOOL shouldShowSignInMessage;

@end
