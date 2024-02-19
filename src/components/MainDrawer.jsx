// Import necessary modules from React and React Native
import React from "react";
import { createDrawerNavigator, DrawerContentScrollView, DrawerItemList } from "@react-navigation/drawer";
import { View, Text, StyleSheet, Image } from 'react-native';

// Import the Dashboard component
import {
 SplashScreen,
  Login,
  Signup,
  Forgotpass,
  RePass,
  Otpverf,
  DashBoard,
  DeviceDashboard,
  UserProfile,
  Settings,
  Notification,
} from "../index";

// Create a Drawer Navigator
const Drawer = createDrawerNavigator();

// Define a custom drawer content component with enhanced styling
const CustomDrawerContent = (props) => (
  // Scrollable view for the drawer content with custom styling
 
  <DrawerContentScrollView {...props} style={styles.drawerContainer}>
    {/* Container for the entire drawer content */}
   
    <View style={styles.drawerContentContainer}>
      {/* Header section with the title "Menu" */}

      <View style={styles.drawerHeader}>
        <Text style={styles.drawerHeaderText}>Menu</Text>
      </View>

      {/* Container to clip content to rounded corners */}
      <View style={styles.clipContainer}>
        {/* Default drawer items list with enhanced label style */}
        <DrawerItemList 
          {...props} 
          labelStyle={{ color: '#C7F2D8' }}
        />
      </View>

    </View>

  </DrawerContentScrollView>
);

// Define an image icon for the Home screen
const HomeIcon = require('../../assets/icons/home (1).png');
const DeviceDashboardIcon = require('../../assets/icons/device.png');
const ProfileIcon = require('../../assets/icons/profile.png');
const NotificationIcon = require('../../assets/icons/bell.png');
const SettingIcon = require('../../assets/icons/settings (1).png');
const LogoutIcon = require('../../assets/icons/exit.png');

// Main Drawer Navigator component
const MainDrawer = () => (
  <Drawer.Navigator
    initialRouteName="Home"
    // Customize drawer background color
    drawerStyle={{
      backgroundColor: "#C7F2D8",
    }}

    // Use the custom drawer content component
    drawerContent={props => <CustomDrawerContent {...props} />}
  >
    {/* Home Screen with custom options, icon, and header hidden */}
    <Drawer.Screen
      name="Home"
      component={DashBoard}
      options={{
        drawerLabel: "Home",
        drawerIcon: ({ focused, color, size }) => (
          // Custom Home icon with specific size and tint color
          <Image
            source={HomeIcon}
            style={{
              width: size,
              height: size,
              tintColor: 'black',
            }}
          />
        ),

        // Hide the header for this screen
        headerShown: false,
      }}
    />
    {/* Add more screens as needed */}
    
    
     <Drawer.Screen
      name="DeviceScreen"
      component={DeviceDashboard}
      options={{
        drawerLabel: "Device Dashboard",
        drawerIcon: ({ focused, color, size }) => (
          // Custom Home icon with specific size and tint color
          <Image
            source={DeviceDashboardIcon} //call image from  const DeviceDashboardIcon = require('../../assets/icons/device.png');
            style={{
              width: size,
              height: size,
              tintColor: 'black',
            }}
          />
        ),
        // Hide the header for this screen
        headerShown: false,
      }}
    />
    <Drawer.Screen
      name="Profile"
      component={UserProfile}
      options={{
        drawerLabel: "Profile",
        drawerIcon: ({ focused, color, size }) => (
          // Custom Home icon with specific size and tint color
          <Image
            source={ProfileIcon} //call image from  const DeviceDashboardIcon = require('../../assets/icons/device.png');
            style={{
              width: size,
              height: size,
              tintColor: 'black',
            }}
          />
        ),
        // Hide the header for this screen
        headerShown: false,
      }}
    />
        <Drawer.Screen
      name="Notification"
      component={Notification}
      options={{
        drawerLabel: "Notification",
        drawerIcon: ({ focused, color, size }) => (
          // Custom Home icon with specific size and tint color
          <Image
            source={NotificationIcon} //call image from  const DeviceDashboardIcon = require('../../assets/icons/device.png');
            style={{
              width: size,
              height: size,
              tintColor: 'black',
            }}
          />
        ),
        // Hide the header for this screen
        headerShown: false,
      }}
    />
    <Drawer.Screen
      name="Setting"
      component={Settings}
      options={{
        drawerLabel: "Setting",
        drawerIcon: ({ focused, color, size }) => (
          // Custom Home icon with specific size and tint color
          <Image
            source={SettingIcon} //call image from  const DeviceDashboardIcon = require('../../assets/icons/device.png');
            style={{
              width: size,
              height: size,
              tintColor: 'black',
            }}
          />
        ),
        // Hide the header for this screen
        headerShown: false,
      }}
    />
    <Drawer.Screen
      name="Login"
      component={Login}
      options={{
        drawerLabel: "Logout",
        drawerIcon: ({ focused, color, size }) => (
          // Custom Home icon with specific size and tint color
          <Image
            source={LogoutIcon} //call image from  const DeviceDashboardIcon = require('../../assets/icons/device.png');
            style={{
              width: size,
              height: size,
              tintColor: 'black',
            }}
          />
        ),
        // Hide the header for this screen
        headerShown: false,
      }}
    />
  </Drawer.Navigator>
);

const styles = StyleSheet.create({
  drawerContainer: {
    flex: 1,
    backgroundColor: "#C7F2D8",
    borderTopRightRadius: 80,  // Adjusted value
    borderBottomRightRadius: 80,  // Adjusted value
  },
  drawerContentContainer: {
    flex: 1,
    flexDirection: "column",
  },
  drawerHeader: {
    height: 100,
    justifyContent: "center",
    paddingLeft: 20,
    overflow: 'hidden',  // Ensure the content doesn't overflow the rounded corners
  },
  drawerHeaderText: {
    color: "black",
    fontSize: 30,
    fontWeight: "bold",
  },
});

export default MainDrawer;