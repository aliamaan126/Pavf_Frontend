import React from 'react';
import { View, Image,StyleSheet, ImageBackground, SafeAreaView, StatusBar} from 'react-native';
import {Text} from 'react-native-elements';
import { LinearGradient } from 'expo-linear-gradient';
import { BlurView } from 'expo-blur';
import AcButton from '../../components/Button';
import {widthPercentageToDP as wp, heightPercentageToDP as hp} from 'react-native-responsive-screen';


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
     
     <StatusBar
        backgroundColor="black"  
        barStyle="white-content"   
        hidden={false}             
      />

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
    flex:1
  },
  container: {
    display:'flex',
    height: hp('100%'),
    width: wp('100%') 
    },
  imagebackground: {
    display:'flex',
    width:'100%',
    height:'100%'
  },
  gradient: {
    width:'100%',
    height:'100%'
  },
  blurView: {
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