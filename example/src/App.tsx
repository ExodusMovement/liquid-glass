import {
  Dimensions,
  Image,
  ScrollView,
  StyleSheet,
  Text,
  View,
} from 'react-native';
import LiquidGlass from '../../src';

const GlassView = ({
  text = 'Hello',
  onPress,
  interactive = false,
  tintColor,
}: {
  text?: string;
  onPress?: () => void;
  interactive?: boolean;
  tintColor?: string;
}) => {
  return (
    <LiquidGlass
      interactive={interactive}
      onPress={onPress}
      style={styles.box}
      effectStyle="clear"
      tintColor={tintColor}
    >
      <Text style={styles.text}>{text}</Text>
    </LiquidGlass>
  );
};

export default function App() {
  return (
    <View style={styles.container}>
      <ScrollView style={styles.scrollView}>
        <Image source={require('./bg.jpg')} />
        <Image source={require('./bg.jpg')} />
        <Image source={require('./bg.jpg')} />
      </ScrollView>
      <View style={styles.dim} />
      <View style={styles.boxContainer}>
        <GlassView
          interactive
          text="Welcome"
          onPress={() => {
            console.log('onPress');
          }}
        />
        <GlassView text="To" tintColor="#9430c2" />
        <GlassView text="Liquid" tintColor="green" />
        <GlassView text="Glass" tintColor="rgb(0,0,255)" />
        <GlassView text="Effect" />
      </View>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  dim: {
    ...StyleSheet.absoluteFillObject,
    backgroundColor: 'rgba(0,0,0,0.5)',
    pointerEvents: 'none',
  },
  box: {
    width: 300,
    height: 64,
    borderRadius: 20,
    justifyContent: 'center',
    alignItems: 'center',
  },
  boxContainer: {
    position: 'absolute',
    gap: 10,
  },
  text: {
    color: 'white',
    fontSize: 30,
    fontWeight: 'bold',
    pointerEvents: 'none',
  },
  textAbsolute: {
    color: 'white',
    fontSize: 30,
    fontWeight: 'bold',
  },
  scrollView: {
    flex: 1,
    width: Dimensions.get('window').width,
  },
});
