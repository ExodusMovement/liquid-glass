#import "LiquidGlassView.h"
#import <React/RCTConvert.h>

#ifdef RCT_NEW_ARCH_ENABLED
#import <react/renderer/components/RNLiquidGlassViewSpec/ComponentDescriptors.h>
#import <react/renderer/components/RNLiquidGlassViewSpec/EventEmitters.h>
#import <react/renderer/components/RNLiquidGlassViewSpec/Props.h>
#import <react/renderer/components/RNLiquidGlassViewSpec/RCTComponentViewHelpers.h>

#import "RCTFabricComponentsPlugins.h"
#endif

#ifdef RCT_NEW_ARCH_ENABLED

using namespace facebook::react;

@interface LiquidGlassView () <RCTLiquidGlassViewViewProtocol>


#else
@interface LiquidGlassView ()
#endif // RCT_NEW_ARCH_ENABLED
@end

@implementation LiquidGlassView {
  UIVisualEffectView *effectView;
  UIGlassEffect *glassEffect;
  UIColor *tintColor;
  BOOL interactive;
}

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap)];
    [self addGestureRecognizer:tapGesture];
  }
  return self;
}

- (void)setUpGlassEffect {
  effectView = [[UIVisualEffectView alloc] init];
  [self setEffectStyle:@"clear"];
  [self addSubview:effectView];
}

- (void)handleTap {
  if (self.onPress) {
    self.onPress(@{});
  }
}

- (void)layoutSubviews {
  [super layoutSubviews];
  if(effectView){
    effectView.layer.cornerRadius = self.layer.cornerRadius;
    effectView.layer.cornerCurve = self.layer.cornerCurve;
    effectView.frame = self.bounds;
  }
}

- (void) updateEffect {
  effectView.effect = glassEffect;
}

- (void)setInteractive:(BOOL)active {
  interactive = active;
  if(glassEffect){
    glassEffect.interactive = interactive;
    [self updateEffect];
  }
}

- (void)setEffectStyle:(NSString *)style {
  glassEffect = [UIGlassEffect effectWithStyle:[style isEqualToString:@"clear"] ? UIGlassEffectStyleClear : UIGlassEffectStyleRegular];
  glassEffect.interactive = interactive;
  glassEffect.tintColor = tintColor;
  [self updateEffect];
}

- (void)setTintColor:(UIColor *)tint{
  tintColor = tint;
  if(glassEffect){
    glassEffect.tintColor = tintColor;
    [self updateEffect];
  }
}

#ifdef RCT_NEW_ARCH_ENABLED
Class<RCTComponentViewProtocol> LiquidGlassViewCls(void) {
  return LiquidGlassView.class;
}
#endif // RCT_NEW_ARCH_ENABLED
@end

