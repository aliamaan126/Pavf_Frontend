import { Image, StyleSheet, Text, View } from "react-native";
import React from "react";
import {
  widthPercentageToDP as wp,
  heightPercentageToDP as hp,
} from "react-native-responsive-screen";
import { TouchableOpacity } from "react-native-gesture-handler";
import MainDrawer from "./MainDrawer";

const SubHeader = ({ heading, img1, img2 }) => {
  return (
    <View style={styles.main}>
      <View style={styles.container}>
        <View style={styles.ImgRight}>
          <TouchableOpacity >
            <Image source={img1} resizeMode="contain" />
          </TouchableOpacity>
        </View>

        <View style={styles.Heading}>
          <Text>{heading}</Text>
        </View>

        <View style={styles.ImgLeft}>
          <TouchableOpacity>
            <Image source={img2} resizeMode="contain" />
          </TouchableOpacity>
        </View>
      </View>
    </View>
  );
};

export default SubHeader;

const styles = StyleSheet.create({
  main: {
    paddingBottom: 20,
  },
  container: {
    display: "flex",
    flexDirection: "row",
    height: hp("10%"),
    width: wp("100%"),
    backgroundColor: "#C9E9C9",
    justifyContent: "center",
    alignItems: "center",
  },
  ImgRight: {
    flex: 1,
    alignContent: "flex-start",
    alignItems: "flex-start",
  },
  Heading: {
    flex: 1,
    alignContent: "center",
    alignItems: "center",
  },
  ImgLeft: {
    flex: 1,
    alignItems: "flex-end",
  },
});
