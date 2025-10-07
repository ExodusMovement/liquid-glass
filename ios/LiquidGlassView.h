// This guard prevent this file to be compiled in the old architecture.

#import <UIKit/UIKit.h>
#ifdef RCT_NEW_ARCH_ENABLED
#import <React/RCTViewComponentView.h>

#import <React/RCTComponent.h>

#ifndef LiquidGlassViewNativeComponent_h
#define LiquidGlassViewNativeComponent_h
#endif /* LiquidGlassViewNativeComponent_h */

#else
#import <React/RCTView.h>
#import <React/RCTComponent.h>
#endif // RCT_NEW_ARCH_ENABLED




NS_ASSUME_NONNULL_BEGIN

@interface LiquidGlassView :
#ifdef RCT_NEW_ARCH_ENABLED
RCTViewComponentView
#else
UIView
#endif // RCT_NEW_ARCH_ENABLED
// @property (nonatomic, strong, nullable) RCTBubblingEventBlock onPress;
@property (nonatomic, copy) RCTBubblingEventBlock onPress;

- (void) setUpGlassEffect;

@end

NS_ASSUME_NONNULL_END


