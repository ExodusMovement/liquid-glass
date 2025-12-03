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
  return [[LiquidGlassView alloc] init];
}

RCT_EXPORT_VIEW_PROPERTY(onPress, RCTBubblingEventBlock);
RCT_EXPORT_VIEW_PROPERTY(interactive, BOOL);
RCT_EXPORT_VIEW_PROPERTY(effectStyle, NSString);
RCT_EXPORT_VIEW_PROPERTY(tintColor, UIColor);
RCT_EXPORT_VIEW_PROPERTY(borderTopLeftRadius, CGFloat)
RCT_EXPORT_VIEW_PROPERTY(borderTopRightRadius, CGFloat)
RCT_EXPORT_VIEW_PROPERTY(borderBottomLeftRadius, CGFloat)
RCT_EXPORT_VIEW_PROPERTY(borderBottomRightRadius, CGFloat)
RCT_EXPORT_VIEW_PROPERTY(glassEnabled, BOOL);


@end
