#import <React/RCTViewManager.h>
#import <React/RCTUIManager.h>
#import "RCTBridge.h"
#import "LiquidGlassView.h"
#import "Utils.h"

@interface LiquidGlassViewManager : RCTViewManager
@end

@implementation LiquidGlassViewManager

RCT_EXPORT_MODULE(LiquidGlassView)

- (UIView *)view {
  LiquidGlassView *liquidGlassView = [[LiquidGlassView alloc] init];
  [liquidGlassView setUpGlassEffect];
  return liquidGlassView;
}

RCT_EXPORT_VIEW_PROPERTY(onPress, RCTBubblingEventBlock);
RCT_EXPORT_VIEW_PROPERTY(interactive, BOOL);
RCT_EXPORT_VIEW_PROPERTY(effectStyle, NSString*);
RCT_EXPORT_VIEW_PROPERTY(tintColor, UIColor);


@end
