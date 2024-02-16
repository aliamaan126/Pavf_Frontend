import "react-native-gesture-handler";
import { SafeAreaView, StyleSheet } from "react-native";
import { NavigationContainer } from "@react-navigation/native";
import { createStackNavigator } from "@react-navigation/stack";
import MainDrawer from "./src/components/MainDrawer";
import {
  DashBoard,
  Login,
  Signup,
  SplashScreen,
  Forgotpass,
  Otpverf,
  RePass,
  DeviceDashboard,
} from "./src/index";
import { useFonts } from "expo-font";
import { useCallback, useState } from "react";

const Stack = createStackNavigator();
export default function App() {
  const [fontsloaded] = useFonts({
    medium: require("./assets/fonts/Inter-Medium.ttf"),
    regular: require("./assets/fonts/Inter-Regular.ttf"),
    thin: require("./assets/fonts/Inter-Thin.ttf"),
    bold: require("./assets/fonts/Inter-Bold.ttf"),
    extrabold: require("./assets/fonts/Inter-ExtraBold.ttf"),
    extralight: require("./assets/fonts/Inter-ExtraLight.ttf"),
    semibold: require("./assets/fonts/Inter-SemiBold.ttf"),
  });

  const onLayoutRootVIew = useCallback(async () => {
    if (fontsloaded) {
      await SplashScreen.hideAsync();
    }
  }, [fontsloaded]);

  return (
    <SafeAreaView style={styles.safeArea}>
      <NavigationContainer>
        <Stack.Navigator
          initialRouteName="Start"
          screenOptions={{ headerShown: false }}
        >
          <Stack.Screen name="Start" component={SplashScreen} />
          <Stack.Screen name="Login" component={Login} />
          <Stack.Screen name="Signup" component={Signup} />
          <Stack.Screen name="Forgotpass" component={Forgotpass} />
          <Stack.Screen name="OTPVerification" component={Otpverf} />
          <Stack.Screen name="ResetPass" component={RePass} />
          <Stack.Screen name="Dashboard" component={MainDrawer} />
          <Stack.Screen name="DeviceDashboard" component={DeviceDashboard} />
        </Stack.Navigator>
      </NavigationContainer>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: "#fff",
    alignItems: "center",
    justifyContent: "center",
  },
  safeArea: {
    flex: 1,
    justifyContent: "center",
  },
});
