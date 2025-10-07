#import "LiquidGlassView.h"

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

- (void) setUpGlassEffect {
  effectView = [[UIVisualEffectView alloc] init];
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

- (void) setInteractive:(BOOL)active {
  interactive = active;
  if(glassEffect){
    glassEffect.interactive = interactive;
  }
}

- (void) setEffectStyle:(NSString *)style {
  glassEffect = [UIGlassEffect effectWithStyle:[style isEqualToString:@"clear"] ? UIGlassEffectStyleClear : UIGlassEffectStyleRegular];
  glassEffect.interactive = interactive;
  effectView.effect = glassEffect;
}

#ifdef RCT_NEW_ARCH_ENABLED
Class<RCTComponentViewProtocol> LiquidGlassViewCls(void) {
  return LiquidGlassView.class;
}
#endif // RCT_NEW_ARCH_ENABLED
@end

