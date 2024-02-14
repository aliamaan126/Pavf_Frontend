import React from 'react';
import { View, Image, StyleSheet, ImageBackground, SafeAreaView } from 'react-native';
import { Text } from 'react-native-elements';
import { LinearGradient } from 'expo-linear-gradient';
import { BlurView } from 'expo-blur';
import AcButton from '../../components/Button';
import OTPVerificationBox from '../../components/OTPVerificationBox';

const Otpverf = ({ navigation }) => {
  return (
    <SafeAreaView style={styles.safeArea}>
      <View style={styles.container}>
        <ImageBackground
          source={require('../../../assets/background1.jpg')}
          resizeMode="cover"
          style={styles.imagebackground}
          imageStyle={{ opacity: 0.9 }}>
          <BlurView style={styles.blurView} intensity={0}>
            <LinearGradient colors={['rgba(3, 3, 1, 0.5)', 'rgba(3, 3, 1, 0.5)']} style={styles.gradient}>
              <View style={styles.LogoView}>
                <Image
                  source={require('../../../assets/logo.png')}
                  style={styles.Logo}
                />
              </View>

              <View style={styles.HeadingView}>
                <Text style={styles.Heading}>Verification</Text>
              </View>

              <View style={styles.otpContainer}>
                <OTPVerificationBox />
              </View>

              <View style={styles.buttonView}>
                <AcButton title="Send OTP" onPress={() => { navigation.navigate("ResetPass") }} style={styles.button}></AcButton>
              </View>

            </LinearGradient>
          </BlurView>
        </ImageBackground>
      </View>
    </SafeAreaView>
  );
};

export default Otpverf;

const styles = StyleSheet.create({
  safeArea: {
    flex: 1,
    position: 'absolute',
    width: '100%',
    height: '100%'
  },
  container: {
    flex: 1,
  },
  imagebackground: {
    flex: 1,
    width: '100%'
  },
  gradient: {
    flex: 1,
  },
  blurView: {
    flex: 1,
  },
  LogoView: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    marginTop: 140,
    marginBottom: 0
  },
  Logo: {
    borderRadius: 200,
    height: 150,
    width: 150,
  },
  HeadingView: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    marginTop: 40,
    marginBottom: 20
  },
  Heading: {
    fontSize: 30,
    textAlign: 'center',
    color: 'white',
    fontFamily:'bold'
  },
  otpContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    marginTop: 20,
    marginBottom: 20,
  },
  buttonView: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    marginTop: 0,
    marginBottom: 130
  },
  button: {
    width: 270,
    height: 50,
    borderRadius: 50,
    backgroundColor: "#0F9F4A"
  },
});
