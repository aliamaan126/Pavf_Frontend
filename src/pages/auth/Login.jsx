import React, { useState } from 'react';
import { View, Image,StyleSheet, ImageBackground, SafeAreaView} from 'react-native';
import {Text} from 'react-native-elements';
import { LinearGradient } from 'expo-linear-gradient';
import { BlurView } from 'expo-blur';
import AcButton from '../../components/Button';
import AcTextField from '../../components/TextField';
import { TouchableOpacity } from 'react-native-gesture-handler';
import {widthPercentageToDP as wp, heightPercentageToDP as hp} from 'react-native-responsive-screen';



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
     intensity={0.5}>
     <LinearGradient colors={['rgba(3, 3, 1, 0.6)', 'rgba(3, 3, 1, 0.6)']}
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
    justifyContent:'center',
    alignItems:'center',
    marginTop:70,
    marginBottom:0
  },
  Logo: {
    borderRadius:200,
    height:150,
    width:150,
  },
  HeadingView:{
    justifyContent:'center',
    alignItems:'center',
    marginTop:20,
    marginBottom:20    
  },
  Heading:{
    fontSize:30,
    textAlign:'center',
    color:'white',
  },  
  textFiledView:{
    justifyContent:'center',
    alignItems:'center',
    marginTop:20,
    marginBottom:40
  },
  textField:{
    backgroundColor:'rgba(156, 242, 189, 0.5)',
    borderColor:'rgba(156, 242, 189, 0.5)',
    color:'white'
  },
  buttonView:{
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
    justifyContent:'center',
    alignItems:'center',
    marginTop:10,
    textDecorationLine:'underline'
  },
  textView2:{
    justifyContent:'center',
    alignItems:'center',
    marginTop:100
  },
  text:{
    fontSize: 15,
    color:"#24C8D2"
  }
});