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
}: {
  text?: string;
  onPress?: () => void;
  interactive?: boolean;
}) => {
  return (
    <LiquidGlass
      interactive={interactive}
      onPress={onPress}
      style={styles.box}
      effectStyle="clear"
    >
      <Text style={styles.text}>{text}</Text>
    </LiquidGlass>
  );
};

export default function App() {
  return (
    <View style={styles.container}>
      <ScrollView style={styles.scrollView}>
        <Image source={require('./aswan.jpg')} />
        <Image source={require('./aswan.jpg')} />
        <Image source={require('./aswan.jpg')} />
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
        <GlassView text="To" />
        <GlassView text="Liquid" />
        <GlassView text="Glass" />
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
