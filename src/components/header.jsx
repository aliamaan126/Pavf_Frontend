import React from 'react';
import { View, Text, TouchableOpacity, ImageBackground, Image, StyleSheet } from 'react-native';

const Header = () => {
    return (

      <ImageBackground
        source={require('../../assets/icons/plant.jpg')}
        style={styles.imgBackground}
      >
      
      <View  style={styles.menuButtonContainer}>
      <TouchableOpacity >
      <Image
        source={require('../../assets/icons/menu.png')}
        style={styles.menuButton}
      />
      </TouchableOpacity>
      </View>

      <View style={styles.textView}>
      <Text style={styles.text}>HI USER</Text>
      </View>  

        {/* Profile image on the right side */}
      <TouchableOpacity>
      <Image
        source={require('../../assets/icons/profile.png')}
        style={styles.profileButton}
      />
      </TouchableOpacity>
      </ImageBackground>
    );
};

const styles = StyleSheet.create({
  imgBackground:{
    flex: 1,
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    paddingHorizontal: 15,
    width: '110%',
    height: 150,
    resizeMode:"cover",
    color:"rgba(163, 163, 163, 0.8)"
  },

  textView:{
    flex:1,
    justifyContent:'center',
    alignItems: 'center',
    marginLeft:15,
    marginBottom: 45,
  },

  text: {
    fontSize: 20,
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
  }

});

export default Header;
