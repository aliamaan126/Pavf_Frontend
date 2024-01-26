import React from 'react';
import { View, Image,StyleSheet, ImageBackground, SafeAreaView} from 'react-native';
import { Button ,Text} from 'react-native-elements';
import { StatusBar } from 'expo-status-bar';
import { LinearGradient } from 'expo-linear-gradient';
import { BlurView } from 'expo-blur';


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
    <Text style={styles.text}>Pak Agro{'\n'}Vertical Farming</Text>
    <Button 
    style={styles.button}
    title={"Get Started"} 
    onPress={()=>{navigation.navigate("Login")}}
    />
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
  container: {
    flex: 1,
  },
  imagebackground: {
    flex: 1,
    justifyContent: 'center',
  },
  LogoView:
  {
    flex:1,
    justifyContent:'center',
    alignItems: 'center',
  },
  Logo: {
    borderRadius:200,
    height:180,
    width:180,
  },
  safeArea: {
    flex:1, 
    justifyContent:'center',
    paddingTop:StatusBar.currentHeight
  },
  text:{
    fontSize:30,
    textAlign:'center',
    color:'white',
  },
  gradient: {
    flex: 1,
  },
  blurView: {
    flex: 1,
  },
  button:{
    width:240,
    height:45,
    paddingHorizontal: 20,
    paddingVertical: 5,
    borderRadius: 50,
    backgroundColor: "#0F9F4A",
    wordWrap: 'break-word'
  },
});