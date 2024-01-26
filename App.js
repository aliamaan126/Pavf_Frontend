import 'react-native-gesture-handler';
import { StatusBar } from 'expo-status-bar';
import { SafeAreaView, StyleSheet, Text, View } from 'react-native';
import { NavigationContainer } from '@react-navigation/native';
import { createStackNavigator } from '@react-navigation/stack';
import {DashBoard, Login, Signup, SplashScreen} from './src/index';

const Stack = createStackNavigator();
export default function App() {
  return (
    <SafeAreaView style={styles.safeArea}>
    <NavigationContainer>
    <Stack.Navigator initialRouteName='Start' screenOptions={{headerShown:false}}>
    <Stack.Screen name="Start" component={SplashScreen} />
    <Stack.Screen name="Login" component={Login} />
    <Stack.Screen name="Signup" component={Signup} />
    <Stack.Screen name="Dashboard" component={DashBoard}/>
    </Stack.Navigator> 
    </NavigationContainer>   
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
    alignItems: 'center',
    justifyContent: 'center',
  },
  safeArea: {
    flex:1, 
    justifyContent:'center',
    paddingTop:StatusBar.currentHeight
  }
});
