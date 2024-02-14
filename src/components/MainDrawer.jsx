import { StyleSheet, Text, View } from "react-native";
import React from "react";
import { createDrawerNavigator } from "@react-navigation/drawer";
import DashBoard from "../pages/home/Dashboard";

const Drawer = createDrawerNavigator();

const MainDrawer = () => {
  return (
      <View>
        <Drawer.Navigator>
          <Drawer.Screen name="Home" component={DashBoard} />
        </Drawer.Navigator>
      </View>
  );
};

export default MainDrawer;

const styles = StyleSheet.create({});
