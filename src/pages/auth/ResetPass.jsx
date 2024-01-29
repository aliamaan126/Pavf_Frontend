import { View, Image,StyleSheet, ImageBackground, SafeAreaView} from 'react-native';
import {Text} from 'react-native-elements';
import { LinearGradient } from 'expo-linear-gradient';
import { BlurView } from 'expo-blur';
import AcButton from '../../components/Button';
import AcTextField from '../../components/TextField';

const RePass = ({navigation}) => {
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
    <Text style={styles.Heading}>Set New Password</Text>
    </View>

    <View style={styles.textFiledView}>
    <AcTextField placeholder={'Password'} backgroundColor={'rgba(156, 242, 189, 0.5)'} borderColor={'rgba(156, 242, 189, 0.5)'} color={'white'}></AcTextField>
    <AcTextField placeholder={'Confirm Password'} backgroundColor={'rgba(156, 242, 189, 0.5)'} borderColor={'rgba(156, 242, 189, 0.5)'} color={'white'}></AcTextField>
    </View>

    <View>
    </View>

    <View style={styles.buttonView}>
    <AcButton title="Confirm" onPress={()=>{navigation.navigate("Login")}} style={styles.button}></AcButton>
    </View>


    </LinearGradient>
    </BlurView>
    </ImageBackground>
    </View>
    
    </SafeAreaView>
  )
}

export default RePass

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
  marginTop:20,
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
  marginBottom:130
},
button:{
  width:270,
  height:50,
  borderRadius: 50,
  backgroundColor: "#0F9F4A"
},

});