import React, { useState } from 'react';
import { View, Image,StyleSheet, ImageBackground, SafeAreaView} from 'react-native';
import {Text} from 'react-native-elements';
import { LinearGradient } from 'expo-linear-gradient';
import { BlurView } from 'expo-blur';
import AcButton from '../../components/Button';
import AcTextField from '../../components/TextField';
import { TouchableOpacity } from 'react-native-gesture-handler';


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
     <LinearGradient colors={['rgba(3, 3, 1, 0.5)', 'rgba(3, 3, 1, 0.5)']}
     style={styles.gradient}>

    <View style={styles.LogoView}>
    <Image 
    source={require('../../../assets/logo.png')} 
    style={styles.Logo}
    />
    </View>

    <View style={styles.HeadingView}>
    <Text style={styles.Heading}>LOG IN</Text>
    </View>

    <View style={styles.textFiledView}>
    <AcTextField placeholder={'Username or Email'} backgroundColor={'rgba(156, 242, 189, 0.5)'} borderColor={'rgba(156, 242, 189, 0.5)'} color={'white'}></AcTextField>
    <AcTextField placeholder={'Password'} backgroundColor={'rgba(156, 242, 189, 0.5)'} borderColor={'rgba(156, 242, 189, 0.5)'} color={'white'}></AcTextField>
    </View>

    <View>
    </View>

    <View style={styles.buttonView}>
    <AcButton title="LOG IN" onPress={()=>{navigation.navigate("Dashboard")}} style={styles.button}></AcButton>
    </View>

    <View style={styles.textView1}>
    <TouchableOpacity onPress={()=>{navigation.navigate("Forgotpass")}}>
    <Text style={styles.text}>Forgot Password</Text>
    </TouchableOpacity>
    </View>

    <View style={  styles.textView2}>
    <TouchableOpacity onPress={()=>{navigation.navigate("Signup")}}>
    <Text style={styles.text}>New Here? Signup</Text>
    </TouchableOpacity>
    </View>

    </LinearGradient>
    </BlurView>
    </ImageBackground>
    </View>
    
    </SafeAreaView>
  );
};

export default Login;

const styles = StyleSheet.create({
    safeArea: {
    flex:1,
    position:'absolute',
    width:'100%',
    height:'100%'
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
    marginTop:140,
    marginBottom:0
  },
  Logo: {
    borderRadius:200,
    height:150,
    width:150,
  },
  HeadingView:{
    flex:1,
    justifyContent:'center',
    alignItems:'center',
    marginTop:40,
    marginBottom:20
    
  },
  Heading:{
    fontSize:30,
    textAlign:'center',
    color:'white',
  },
  
  textFiledView:{
    flex:1,
    justifyContent:'center',
    alignItems:'center',
    marginTop:0,
    marginBottom:40
  },
  textField:{
    backgroundColor:'rgba(156, 242, 189, 0.5)',
    borderColor:'rgba(156, 242, 189, 0.5)',
    color:'white'
  },

  buttonView:{
    flex:1,
    justifyContent:'center',
    alignItems:'center',
    marginTop:0,
    marginBottom:0
  },
  button:{
    width:270,
    height:50,
    borderRadius: 50,
    backgroundColor: "#0F9F4A"
  },

  textView1:{
    flex:1,
    justifyContent:'center',
    alignItems:'center',
    marginBottom:50
  },
  textView2:{
    flex:1,
    justifyContent:'center',
    alignItems:'center',
  },
  text:{
    fontSize: 15,
    color:"#24C8D2"
  }

});