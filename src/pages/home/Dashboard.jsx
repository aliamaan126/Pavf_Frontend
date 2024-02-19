import React from "react";
import { View, ScrollView, StyleSheet, Text } from "react-native";
import Header from "../../components/header";
import View_Rreadings from "../../components/View_Rreadings";
import {
  widthPercentageToDP as wp,
  heightPercentageToDP as hp,
} from "react-native-responsive-screen";

const DashBoard = ({ navigation }) => {
  return (
    <ScrollView style={styles.container}>
      {/* Header */}
      <Header />

      {/* Body */}
      <View_Rreadings />

      {/* Footer */}
      <View style={styles.main}>
        <View style={styles.container}>
          <Text>Device Connection</Text>
        </View>
      </View>
    </ScrollView>
  );
};

const styles = StyleSheet.create({
  main: {
    flex: 1,
    justifyContent: "flex-end",
  },
  container: {
    height: hp("10%"),
    width: wp("100%"),
    backgroundColor: "#C9E9C9",
    
  },
});

export default DashBoard;
