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
    BOOL _glassEnabled;
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
        _glassEnabled = YES;
        
        [self setUpGlassEffect];
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap)];
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}

- (void)setUpGlassEffect {
    if (effectView || !_glassEnabled) {
        return;
    }
    effectView = [[UIVisualEffectView alloc] init];
    [super addSubview:effectView];
}

#pragma mark - Child View Management

- (void)insertReactSubview:(UIView *)subview atIndex:(NSInteger)atIndex
{
    if (_glassEnabled && effectView) {
        [effectView.contentView insertSubview:subview atIndex:atIndex];
    } else {
        [super insertSubview:subview atIndex:atIndex];
    }
}

- (void)removeReactSubview:(UIView *)subview
{
    [subview removeFromSuperview];
}

#ifdef RCT_NEW_ARCH_ENABLED
- (void)mountChildComponentView:(UIView *)childComponentView index:(NSInteger)index
{
    if (_glassEnabled && effectView) {
        [effectView.contentView insertSubview:childComponentView atIndex:index];
    } else {
        [super addSubview:childComponentView];
    }
}

- (void)unmountChildComponentView:(UIView *)childComponentView atIndex:(NSInteger)index
{
    [childComponentView removeFromSuperview];
}
#endif

#pragma mark - Layout and Effect Updates

- (void)layoutSubviews {
    [super layoutSubviews];

    if (!_glassEnabled) {
        return;
    }

    [self updateGlassEffectIfNeeded];

    if(effectView){
        effectView.frame = self.bounds;
        
        if(self.borderBottomLeftRadius && self.borderTopLeftRadius && self.borderTopRightRadius && self.borderBottomRightRadius){
            
            CGFloat overrideRadius = 0.0;
            if (self.borderTopLeftRadius > 0.0) {
                overrideRadius = self.borderTopLeftRadius;
            } else if (self.borderTopRightRadius > 0.0) {
                overrideRadius = self.borderTopRightRadius;
            } else if (self.borderBottomLeftRadius > 0.0) {
                overrideRadius = self.borderBottomLeftRadius;
            } else if (self.borderBottomRightRadius > 0.0) {
                overrideRadius = self.borderBottomRightRadius;
            }
            
            
            CGFloat topLeftValue = (self.borderTopLeftRadius > 0.0)
            ? self.borderTopLeftRadius
            : overrideRadius;
            
            UICornerRadius *topLeft = [UICornerRadius fixedRadius:topLeftValue];
            
            CGFloat topRightValue = (self.borderTopRightRadius > 0.0)
            ? self.borderTopRightRadius
            : overrideRadius;
            
            UICornerRadius *topRight = [UICornerRadius fixedRadius:topRightValue];
            
            CGFloat bottomLeftValue = (self.borderBottomLeftRadius > 0.0)
            ? self.borderBottomLeftRadius
            : overrideRadius;
            
            UICornerRadius *bottomLeft = [UICornerRadius fixedRadius:bottomLeftValue];
            
            CGFloat bottomRightValue = (self.borderBottomRightRadius > 0.0)
            ? self.borderBottomRightRadius
            : overrideRadius;
            
            UICornerRadius *bottomRight = [UICornerRadius fixedRadius:bottomRightValue];
            
            effectView.cornerConfiguration = [UICornerConfiguration configurationWithTopLeftRadius:topLeft
                                                                                    topRightRadius:topRight
                                                                                  bottomLeftRadius:bottomLeft
                                                                                 bottomRightRadius:bottomRight];
        }else{
            effectView.layer.cornerRadius = self.layer.cornerRadius;
            effectView.layer.cornerCurve = self.layer.cornerCurve;
        }
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

- (void)setGlassEnabled:(BOOL)glassEnabled {
    if (_glassEnabled == glassEnabled) return;

    _glassEnabled = glassEnabled;

    if (!_glassEnabled) {
        if (effectView) {
            [effectView removeFromSuperview];
            effectView = nil;
        }
    } else {
        [self setUpGlassEffect];
        _effectNeedsUpdate = YES;
    }

    [self setNeedsLayout];
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
