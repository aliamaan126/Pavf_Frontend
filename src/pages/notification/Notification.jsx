import React from "react";
import { StyleSheet, Text, TouchableOpacity, View, Image } from "react-native";
import NotificationSubHeader from "../../components/notificationsubheader";
import SubFooter from "../../components/SubFooter";
import { widthPercentageToDP as wp, heightPercentageToDP as hp } from "react-native-responsive-screen";
import { SwipeListView } from "react-native-swipe-list-view";

const colors = {
  primary: '#3498db',
  secondary: '#2ecc71',
  background: '#ecf0f1',
  text: '#333',
};

const font = {
  regular: 'Roboto-Regular',
  bold: 'Roboto-Bold',
};

const Notification = () => {
  const notifications = [
    { id: 1, icon: require("../../../assets/icons/filter.png"), heading: "Notification 1", reason: "Reason 1", date: "today" },
    { id: 10, icon: require("../../../assets/icons/filter.png"), heading: "Notification 1", reason: "Reason 1", date: "today" },
    { id: 2, icon: require("../../../assets/icons/device.png"), heading: "Notification 2", reason: "Reason 2", date: "yesterday" },
    { id: 3, icon: require("../../../assets/icons/M.png"), heading: "Notification 3", reason: "Reason 3", date: "today" },
    { id: 4, icon: require("../../../assets/icons/M.png"), heading: "Notification 4", reason: "Reason 4", date: "yesterday" },
    { id: 5, icon: require("../../../assets/icons/M.png"), heading: "Notification 4", reason: "Reason 4", date: "yesterday" },
  ];

  const renderNotificationItem = ({ item }) => (
    <View style={styles.notificationContainer}>
      <View style={styles.notificationBox}>
        <Image source={item.icon} style={styles.icon} />
        <View>
          <Text style={styles.heading}>{item.heading}</Text>
          <Text style={styles.reason}>{item.reason}</Text>
        </View>
      </View>
    </View>
  );

  const renderHiddenItem = () => (
    <View style={styles.rowBack}>
      <TouchableOpacity style={[styles.backLeftBtn, styles.backLeftBtnLeft]}>
        <Image source={require("../../../assets/icons/Archive.png")} style={styles.iconLeft} />
      </TouchableOpacity>
    </View>
  );

  return (
    <View style={styles.container}>
      <NotificationSubHeader
        heading={"Notification"}
        img1={require("../../../assets/icons/menu2.png")}
        img2={require("../../../assets/icons/filter.png")}
      />
      <Text style={styles.dateHeading}>Today</Text>
      <SwipeListView
        data={notifications.filter(item => item.date === "today")}
        renderItem={renderNotificationItem}
        renderHiddenItem={renderHiddenItem}
        leftOpenValue={wp("15%")} // Adjusted leftOpenValue
        disableLeftSwipe={true}
        rightOpenValue={-75}
      />
      <Text style={styles.dateHeading}>Yesterday</Text>
      <SwipeListView
        data={notifications.filter(item => item.date === "yesterday")}
        renderItem={renderNotificationItem}
        renderHiddenItem={renderHiddenItem}
        leftOpenValue={wp("18.5%")} // Adjusted leftOpenValue
        disableLeftSwipe={true}
        rightOpenValue={-15}
      />
      <SubFooter />
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    height: hp("100%"),
    width: wp("100%"),
    backgroundColor: '#C9E9C9'
  },
  notificationContainer: {
    paddingHorizontal: 15,
    marginVertical: 5,
  },
  notificationBox: {
    height: wp("24"),
    flexDirection: "row",
    alignItems: "center",
    backgroundColor: "#FFFFFF",
  },
  icon: {
    width: 40,
    height: 40,
    borderRadius: 25,
    marginRight: 15,
    marginLeft: 15,
  },
  heading: {
    fontSize: 14,
    fontWeight: "bold",
    fontFamily: font.bold,
  },
  reason: {
    fontSize: 12,
    fontFamily: font.regular,
  },
  dateHeading: {
    fontSize: 16,
    fontWeight: "bold",
    marginVertical: 10,
    marginLeft: 15,
    color: colors.text,
  },
  //headings
  dateHeading:{
  marginHorizontal:20,
  marginVertical:1,
  },
  // swiping code
  rowBack: {
    alignItems: "center",
    backgroundColor: '#C9E9C9',
    flex: 1,
    flexDirection: "row",
    justifyContent: "flex-left", // Align items to the end for left swipe
    paddingLeft: 15, // Add padding to the right
    
  },
  backLeftBtn: {
    alignItems: "center",
    flexDirection: "row",
    padding: 10,
    backgroundColor: colors.primary,
    width: wp("18"), // Adjust the width to control how much of the item is swiped
    height: wp("21.5"),
  },
  backLeftBtnLeft: {
    backgroundColor: '#148B14'
  },
  iconLeft: {
    width: 50,
    height: 50,
    marginRight: 10,
  },
});

export default Notification;
