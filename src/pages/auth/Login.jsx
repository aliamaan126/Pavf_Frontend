import { StyleSheet, Text, View,ImageBackground,Image, SafeAreaView} from 'react-native'
import React from 'react'
import AcButton from '../../components/Button';
import { StatusBar } from 'expo-status-bar';
import { BlurView } from 'expo-blur';
import { LinearGradient } from 'expo-linear-gradient';

const Login = ({navigation}) => {
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
    <Text style={styles.heading}>Log in</Text>
    
    <AcButton title="Log in" onPress={()=>{navigation.navigate("Dashboard")}} style={styles.button}></AcButton>
    </View>
    </LinearGradient>
    </BlurView>
    </ImageBackground>
    </View>
    
    </SafeAreaView>
  )
}

export default Login

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
    height:150,
    width:150,
  },
  safeArea: {
    flex:1, 
    justifyContent:'center',
    paddingTop:StatusBar.currentHeight
  },
  heading:{
    fontSize:30,
    textAlign:'center',
    color:'white',
    marginVertical:25,
  },
  gradient: {
    flex: 1,
  },
  blurView: {
    flex: 1,
  },
  button:{
    width:270,
    height:45,
    paddingHorizontal: 20,
    paddingVertical: 5,
    borderRadius: 50,
    backgroundColor: "#0F9F4A",
    wordWrap: 'break-word'
  },
  });