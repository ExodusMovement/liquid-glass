import codegenNativeComponent from 'react-native/Libraries/Utilities/codegenNativeComponent';
import type { ViewProps } from 'react-native';
import type {
  BubblingEventHandler,
  WithDefault,
} from 'react-native/Libraries/Types/CodegenTypes';

type EffectStyleType = 'clear' | 'regular';
interface NativeProps extends ViewProps {
  onPress?: BubblingEventHandler<{}>;
  interactive?: boolean;
  effectStyle?: WithDefault<EffectStyleType, 'clear'>;
}

export default codegenNativeComponent<NativeProps>('LiquidGlassView');
