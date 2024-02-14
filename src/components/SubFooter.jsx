import { StyleSheet, Text, View } from "react-native";
import React from "react";
import {
  widthPercentageToDP as wp,
  heightPercentageToDP as hp,
} from "react-native-responsive-screen";

const SubFooter = () => {
  return (
    <View style={styles.main}>
      <View style={styles.container}></View>
    </View>
  );
};

export default SubFooter;

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
