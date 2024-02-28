
import { Image,StyleSheet, Text, View, TouchableOpacity } from 'react-native';
import React from 'react';
import FeatherIcon from 'react-native-vector-icons/Feather';
import SubHeader from "../../components/SubHeader";
import SubFooter from "../../components/SubFooter";
import {
  widthPercentageToDP as wp,
  heightPercentageToDP as hp,
} from "react-native-responsive-screen";
import { ScrollView } from "react-native-gesture-handler";

const Settings = () => {
  return (
    <View style={styles.container}>
      
      {/* Include SubHeader component here */}
      <SubHeader heading={"Setting"} 
      img1={require('../../../assets/icons/menu2.png')} 
>     </SubHeader>

      <View style={styles.section}>

        <View style={styles.sectionBody}>
          <View style={[styles.rowWrapper, styles.rowFirst]}>
            <TouchableOpacity
              onPress={() => {
                // handle onPress
              }}
              style={styles.row}>
              <Text style={styles.rowLabel}>Personal Information</Text>

              <View style={styles.rowSpacer} />

              <FeatherIcon
                color="#C6C6C6"
                name="chevron-right"
                size={20}
              />
            </TouchableOpacity>
          </View>
          <View style={styles.rowWrapper}>
            <TouchableOpacity
              onPress={() => {
                // handle onPress
              }}
              style={styles.row}>
              <Text style={styles.rowLabel}>Notification </Text>
              <View style={styles.rowSpacer} />
              <FeatherIcon
                color="#C6C6C6"
                name="chevron-right"
                size={20}
              />
            </TouchableOpacity>
          </View>
         
          <View style={styles.rowWrapper}>
            <TouchableOpacity
              onPress={() => {
                // handle onPress
              }}
              style={styles.row}>
              <Text style={styles.rowLabel}>Privacy and Security </Text>

              <View style={styles.rowSpacer} />

              <FeatherIcon
                color="#C6C6C6"
                name="chevron-right"
                size={20}
              />
            </TouchableOpacity>
          </View>

          <View style={styles.rowWrapper}>
            <TouchableOpacity
              onPress={() => {
                // handle onPress
              }}
              style={styles.row}>
              <Text style={styles.rowLabel}>Terms and Policies</Text>

              <View style={styles.rowSpacer} />

              <FeatherIcon
                color="#C6C6C6"
                name="chevron-right"
                size={20}
              />
            </TouchableOpacity>
          </View>

          <View style={styles.rowWrapper}>
            <TouchableOpacity
              onPress={() => {
                // handle onPress
              }}
              style={styles.row}>
              <Text style={styles.rowLabel}>Rate App</Text>

              <View style={styles.rowSpacer} />

              <FeatherIcon
                color="#C6C6C6"
                name="chevron-right"
                size={20}
              />
            </TouchableOpacity>
          </View>
          
          <View style={styles.rowWrapper}>
            <TouchableOpacity
              onPress={() => {
                // handle onPress
              }}
              style={styles.row}>
              <Text style={styles.rowLabel}>Become a Professional</Text>

              <View style={styles.rowSpacer} />

              <FeatherIcon
                color="#C6C6C6"
                name="chevron-right"
                size={20}
              />
            </TouchableOpacity>
          </View>
          <View style={styles.rowWrapper}>
            <TouchableOpacity
              onPress={() => {
                // handle onPress
              }}
              style={styles.row}>
              <Text style={styles.rowLabel}>About </Text>

              <View style={styles.rowSpacer} />

              <FeatherIcon
                color="#C6C6C6"
                name="chevron-right"
                size={20}
              />
            </TouchableOpacity>
          </View>
        </View>
      </View>
      <SubFooter></SubFooter>
    </View>
    
  );
};

export default Settings;

const styles = StyleSheet.create({
  container: {
    height: hp("100%"),
    width: wp("100%"),
    backgroundColor: '#C9E9C9', // background color
  },
  // body of setting
  section: {
    marginTop: wp(5),
  },
  sectionBody: {
    backgroundColor: '#C9E9C9', // background color
    borderColor: '#e3e3e3',
    paddingLeft: 22,
    paddingRight:22,
    borderTopLeftRadius: 15,
  },
  row: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'flex-start',
    height: 70,
    paddingRight: 24,
  },
  rowWrapper: {
    borderColor: '#e3e3e3',
    marginBottom: 10, // Add some gap between rowWrappers
    borderRadius: 10, // Set the border radius for rounded corners
    
    shadowOffset: {
      width: 10,
      height: 10,
    },
    shadowOpacity: 0.5,
    shadowRadius: 0.5,
    elevation: 1,
    backgroundColor: '#fff',
  },
  rowFirst: {
    borderTopWidth: 0,
  },
  rowLabel: {
    fontSize: 17,
    fontWeight: '500',
    color: '#2c2c2c',
    padding: 10,
  },
  rowSpacer: {
    flexGrow: 1,
    flexShrink: 1,
    flexBasis: 0,
  },
});