import React from "react";
import { Image, StyleSheet, Text, View } from "react-native";
import {
  widthPercentageToDP as wp,
  heightPercentageToDP as hp,
} from "react-native-responsive-screen";
import { TouchableOpacity } from "react-native-gesture-handler";
import { useNavigation } from "@react-navigation/native"; // Import useNavigation hook
import MainDrawer from "./MainDrawer";

const notificationsubheader = ({ heading, img1, img2 }) => {
  const navigation = useNavigation(); // Use useNavigation hook to get navigation object

  const openDrawer = () => {
    navigation.openDrawer(); // Open the drawer when called
  };

  return (
    <View style={styles.main}>
      <View style={styles.container}>
        <View style={styles.ImgRight}>
          <TouchableOpacity onPress={openDrawer}>
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

export default notificationsubheader;

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
    padding:15,
  },
  Heading: {
    flex: 1,
    alignContent: "center",
    alignItems: "center",
  },
  ImgLeft: {
    flex: 1,
    alignItems: "flex-end",
    padding:15,
  },
});
