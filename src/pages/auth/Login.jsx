import { StyleSheet, Text, View,ImageBackground,Image} from 'react-native'
import React from 'react'
import { Button } from 'react-native-elements';
import { ActionTextField } from '../../components/TextField'
import BouncyCheckbox from "react-native-bouncy-checkbox";

const Login = ({navigation}) => {
  return (
    <View 
    style={styles.container}
    >
    <ImageBackground 
    source={require('../../../assets/background.jpg') } 
    resizeMode="cover" 
    style={styles.imagebackground}
    >

    <Image 
    source={require('../../../assets/logo.png')} 
    style={styles.Logo}
    />
    <Text style={styles.label}>LOG IN</Text>

    <ActionTextField 
    placeholder={'Username'} color='black' bcolor='#9CF2BD'
     ></ActionTextField>

    <ActionTextField 
    placeholder={'Password'}
    ></ActionTextField>

    <View 
    style={styles.checkboxContainer}>

    <BouncyCheckbox  
     onPress={() => {}} 
     />

    <Text 
    style={styles.text}>Remember Password</Text>

  </View>

    <Button 
    title={"Log in"} 
    onPress={()=>{
      navigation.navigate("DashBoard")
    }}/>
    
    <Text 
    style={styles.text}>Forgot Password</Text>
   
    <Text 
    style={styles.text}>New Here?Signup</Text>

    </ImageBackground>
    </View>
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
    Logo: {
        flexDirection:'row',
        alignItems:'center',
        borderRadius:100,
        height:150,
        width:150,
    },
    checkboxContainer: {
        flexDirection: 'row',
        marginBottom: 20,
      },
      checkbox: {
        alignSelf: 'center',
      },
      label:{
        color:"white",
        textAlign:'center',
        fontSize:24,
      },
      text:
      {
        color: "#24C8D2",
    },
  });