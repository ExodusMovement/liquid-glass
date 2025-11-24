import { Platform } from 'react-native';
import { LiquidGlassView as LiquidGlassViewNative } from './LiquidGlassView';

export const isLiquidGlassSupported =
  Platform.OS === 'ios' && Number(`${Platform.Version}`.split('.')[0]) >= 26;

export default LiquidGlassViewNative;
