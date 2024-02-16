import { StyleSheet, Text, TouchableOpacity, View } from "react-native";
import React from "react";
import SubHeader from "../../components/SubHeader";
import SubFooter from "../../components/SubFooter";
import {
  widthPercentageToDP as wp,
  heightPercentageToDP as hp,
} from "react-native-responsive-screen";
import { ScrollView } from "react-native-gesture-handler";
import MainDrawer from "../../components/MainDrawer";

const DeviceDashboard = () => {
  return (
    <View style={styles.container}>
   
      <SubHeader heading={"Header"} 
      img1={require('../../../assets/icons/menu2.png')} 
      img2={require('../../../assets/icons/menu.png')}>
        
      </SubHeader>
      <ScrollView>
        <TouchableOpacity>
          <View style={styles.box}>
            <Text>Add Device</Text>
          </View>
        </TouchableOpacity> 
        <MainDrawer>j</MainDrawer>
      </ScrollView>
      <SubFooter></SubFooter>
    </View>
  );
};

export default DeviceDashboard;

const styles = StyleSheet.create({
  container: {
    height: hp("100%"),
    width: wp("100%"),
    backgroundColor: "rgba(255, 255, 255, 0)",
  },
  box: {
    height: 100,
    width: "85%",
    borderRadius: 16,
    display: "flex",
    alignItems: "center",
    backgroundColor: "#FFFFFF",
  },
});
