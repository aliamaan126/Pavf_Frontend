import { StyleSheet, Text, TouchableOpacity, View } from "react-native";
import React from "react";
import NotificationSubHeader from "../../components/notificationsubheader"; // Update import statement
import SubFooter from "../../components/SubFooter";
import {
  widthPercentageToDP as wp,
  heightPercentageToDP as hp,
} from "react-native-responsive-screen";
import { ScrollView } from "react-native-gesture-handler";
import MainDrawer from "../../components/MainDrawer";

const Notification = () => {
  return (
    <View style={styles.container}>
   
      <NotificationSubHeader heading={"Notification"} 
      img1={require('../../../assets/icons/menu2.png')} 
      img2={require('../../../assets/icons/filter.png')}>
      </NotificationSubHeader>
      
      <ScrollView>
        <TouchableOpacity>
          <View style={styles.box}>
            <Text>Add Notification</Text>
          </View>
        </TouchableOpacity> 
        <MainDrawer></MainDrawer>
      </ScrollView>
      <SubFooter></SubFooter>
    </View>
  );
};

export default Notification;

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
