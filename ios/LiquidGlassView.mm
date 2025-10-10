#import "LiquidGlassView.h"
#import <React/RCTConvert.h>

#ifdef RCT_NEW_ARCH_ENABLED
#import <react/renderer/components/RNLiquidGlassViewSpec/ComponentDescriptors.h>
#import <react/renderer/components/RNLiquidGlassViewSpec/EventEmitters.h>
#import <react/renderer/components/RNLiquidGlassViewSpec/Props.h>
#import <react/renderer/components/RNLiquidGlassViewSpec/RCTComponentViewHelpers.h>

#import "RCTFabricComponentsPlugins.h"
#endif // RCT_NEW_ARCH_ENABLED

#ifdef RCT_NEW_ARCH_ENABLED
using namespace facebook::react;
@interface LiquidGlassView () <RCTLiquidGlassViewViewProtocol>
#else
@interface LiquidGlassView ()
#endif // RCT_NEW_ARCH_ENABLED
@end

@implementation LiquidGlassView {
  UIVisualEffectView *effectView;
  UIColor *_tintColor;
  BOOL _interactive;
  UIGlassEffectStyle _effectStyle;
  BOOL _effectNeedsUpdate;
}

#pragma mark - Initialization

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    _interactive = YES;
    _effectStyle = UIGlassEffectStyleClear;
    _tintColor = [UIColor clearColor];
    _effectNeedsUpdate = YES;
    
    [self setUpGlassEffect];
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap)];
    [self addGestureRecognizer:tapGesture];
  }
  return self;
}

- (void)setUpGlassEffect {
  if (effectView) {
    return;
  }
  effectView = [[UIVisualEffectView alloc] init];
  [super addSubview:effectView];
}

#pragma mark - Child View Management

- (void)insertReactSubview:(UIView *)subview atIndex:(NSInteger)atIndex
{
  [effectView.contentView insertSubview:subview atIndex:atIndex];
}

- (void)removeReactSubview:(UIView *)subview
{
  [subview removeFromSuperview];
}

#ifdef RCT_NEW_ARCH_ENABLED
- (void)mountChildComponentView:(UIView *)childComponentView index:(NSInteger)index
{
  [effectView.contentView insertSubview:childComponentView atIndex:index];
}

- (void)unmountChildComponentView:(UIView *)childComponentView atIndex:(NSInteger)index
{
  [childComponentView removeFromSuperview];
}
#endif

#pragma mark - Layout and Effect Updates

- (void)layoutSubviews {
  [super layoutSubviews];
  [self updateGlassEffectIfNeeded];
  if(effectView){
    effectView.frame = self.bounds;
    effectView.layer.cornerRadius = self.layer.cornerRadius;
    effectView.layer.cornerCurve = self.layer.cornerCurve;
  }
}

- (void)updateGlassEffectIfNeeded {
  if (!_effectNeedsUpdate) {
    return;
  }
  
  UIGlassEffect *glassEffect = [UIGlassEffect effectWithStyle:_effectStyle];
  glassEffect.interactive = _interactive;
  glassEffect.tintColor = _tintColor;
  effectView.effect = glassEffect;
  _effectNeedsUpdate = NO;
}

#pragma mark - Prop Setters

- (void)setInteractive:(BOOL)interactive {
  if (_interactive != interactive) {
    // Workaround drop the current effect to make interactivity dynamic
    if(effectView.effect){
      effectView.effect = [[UIVisualEffect alloc] init];
    }
    _interactive = interactive;
    _effectNeedsUpdate = YES;
    [self setNeedsLayout];
  }
}

- (void)setEffectStyle:(NSString *)style {
  UIGlassEffectStyle newStyle = [style isEqualToString:@"regular"] ? UIGlassEffectStyleRegular : UIGlassEffectStyleClear;
  if (_effectStyle != newStyle) {
    _effectStyle = newStyle;
    _effectNeedsUpdate = YES;
    [self setNeedsLayout];
  }
}

- (void)setTintColor:(UIColor *)tint {
  if (![_tintColor isEqual:tint]) {
    _tintColor = tint;
    _effectNeedsUpdate = YES;
    [self setNeedsLayout];
  }
}

#pragma mark - Event Handlers

- (void)handleTap {
  if (self.onPress) {
    self.onPress(@{});
  }
}

#pragma mark - Fabric-Specific Boilerplate

#ifdef RCT_NEW_ARCH_ENABLED
+ (ComponentDescriptorProvider)componentDescriptorProvider
{
  return concreteComponentDescriptorProvider<LiquidGlassViewComponentDescriptor>();
}

- (void)updateProps:(Props::Shared const &)props oldProps:(Props::Shared const &)oldProps
{
  [super updateProps:props oldProps:oldProps];
}
#endif

@end
