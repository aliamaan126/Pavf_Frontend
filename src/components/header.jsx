// components/Header.js

import React from 'react';
import { View, Text, TouchableOpacity, ImageBackground, Image, StyleSheet } from 'react-native';

const Header = ({ onPressMenu }) => {
    return (
      <ImageBackground
        source={require('../../assets/icons/plant.jpg')}
        style={styles.header}
        resizeMode="cover"
      >
        <TouchableOpacity onPress={onPressMenu} style={styles.menuButtonContainer}>
          <Image
            source={require('../../assets/icons/menu.png')}
            style={styles.menuButton}
          />
        </TouchableOpacity>
        <Text style={styles.text}>HI USER</Text>
        
        {/* Profile image on the right side */}
        <Image
          source={require('../../assets/icons/profile.png')}
          style={styles.profileButton}
        />
      </ImageBackground>
    );
};

const styles = StyleSheet.create({
  header: {
    flex: 1,
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    paddingHorizontal: 25,
    width: '110%',
    height: 150,
  },
  text: {
    fontSize: 20,
    marginBottom: 40,
    color: 'white',
  },
  menuButtonContainer: {
    paddingBottom: 50,
  },
  menuButton: {
    width: 30,
    height: 30,
    resizeMode: 'contain',
  },
  menuButtonContainer: {
    paddingBottom: 50,
  },
  profileButton: {
    alignItems: 'center',
    width: 100, // Adjust the width as needed to match menuButton
    height: 50, // Adjust the height as needed
    paddingRight: 15, // Add padding to the right side
    bottom:20,
    resizeMode: 'contain',
  },
});

export default Header;
