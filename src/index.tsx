import React from 'react';
import { Platform } from 'react-native';
import type { ViewProps } from 'react-native';
import { LiquidGlassView as LiquidGlassViewNative } from './LiquidGlassView';

type Props = ViewProps & {
  onPress?: () => void;
  interactive?: boolean;
  effectStyle?: 'clear' | 'regular';
  tintColor?: string;
};

export const isLiquidGlassSupported =
  Platform.OS === 'ios' && Number(`${Platform.Version}`.split('.')[0]) >= 26;

const LiquidGlassView: React.FC<Props> = (props) => {
  if (isLiquidGlassSupported) {
    return <LiquidGlassViewNative {...props} />;
  }

  throw new Error('Liquid Glass should only be used on iOS 26+');
};

export default LiquidGlassView;
