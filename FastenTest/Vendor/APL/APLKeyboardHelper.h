//
//  APLKeyboardHelper.h
//  Client
//
//  Created by Semyon Belokovsky on 24/10/15.
//  Copyright © 2015 App Plus. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^APLKeyboardHelperHandler)(CGSize keyboardSize, double duration);

@interface NSObject (KeyboardHelper)

- (void)handleKeyboardWillShow:(APLKeyboardHelperHandler)handler;
- (void)handleKeyboardDidShow:(APLKeyboardHelperHandler)handler;

- (void)handleKeyboardWillHide:(APLKeyboardHelperHandler)handler;
- (void)handleKeyboardDidHide:(APLKeyboardHelperHandler)handler;

- (void)handleKeyboardWillChange:(APLKeyboardHelperHandler)handler;
- (void)handleKeyboardDidChange:(APLKeyboardHelperHandler)handler;

- (void)cancelHandlingKeyboard;

@end
