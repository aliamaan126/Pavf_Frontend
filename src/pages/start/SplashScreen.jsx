import React from 'react';
import { View, Image,StyleSheet, ImageBackground, SafeAreaView} from 'react-native';
import {Text} from 'react-native-elements';
import { LinearGradient } from 'expo-linear-gradient';
import { BlurView } from 'expo-blur';
import AcButton from '../../components/Button';


const StartupScreen = ({navigation}) => {
  return (
    <SafeAreaView style={styles.safeArea}>
    <View  style={styles.container}> 
    
    <ImageBackground
     source={require('../../../assets/background1.jpg') } 
     resizeMode="cover" 
     style={styles.imagebackground}
     imageStyle={{opacity:0.9}}>
     
     <BlurView style={styles.blurView}
     intensity={0}>
     <LinearGradient colors={['rgba(3, 3, 1, 0.3)', 'rgba(3, 3, 1, 0.3)']}
     style={styles.gradient}>

    <View style={styles.LogoView}>
    <Image 
    source={require('../../../assets/logo.png')} 
    style={styles.Logo}
    />
    </View>

    <View style={styles.textView}>
    <Text style={styles.text}>PAK AGRO{'\n'}VERTICAL FARMING</Text>
    </View>

    <View style={styles.buttonView}>
    <AcButton title="Get Started" onPress={()=>{navigation.navigate("Login")}} style={styles.button}></AcButton>
    </View>

    </LinearGradient>
    </BlurView>
    </ImageBackground>
    </View>
    
    </SafeAreaView>
  );
};

export default StartupScreen;

const styles = StyleSheet.create({
    safeArea: {
    flex:1, 
  },
  container: {
    flex: 1,
  },
  imagebackground: {
    flex: 1,
    width:'100%'
  },
  gradient: {
    flex: 1,
  },
  blurView: {
    flex: 1,
  },
  LogoView:
  {
    flex:1,
    justifyContent:'center',
    alignItems:'center',
    marginTop:200,
    padding:0
  },
  Logo: {
    borderRadius:200,
    height:180,
    width:180,
  },
  textView:{
    flex:1,
    justifyContent:'center',
    alignItems:'center',
    marginTop:30
    
  },
  text:{
    fontSize:30,
    textAlign:'center',
    color:'white',
  },
  
  buttonView:{
    flex:1,
    justifyContent:'center',
    alignItems:'center',
    marginBottom:150,
    marginTop:0
  },
  button:{
    width:270,
    height:45,
    borderRadius: 50,
    backgroundColor: "#0F9F4A"
  },
});