import React from 'react';
import { View, Text, TouchableOpacity, ImageBackground, Image, StyleSheet } from 'react-native';
import { useNavigation } from '@react-navigation/native';
import { DrawerActions } from '@react-navigation/native';

const Header = () => {
  const navigation = useNavigation();

  return (
    <ImageBackground
      source={require('../../assets/icons/plant.jpg')}
      style={styles.imgBackground}
    >
      <View style={styles.menuButtonContainer}>
        <TouchableOpacity
          style={styles.menuButton}
          onPress={() => {
            navigation.dispatch(DrawerActions.openDrawer());
            console.log('Menu button pressed');
          }}
        >
          <Image
            source={require('../../assets/icons/menu.png')}
            style={styles.menuIcon}
          />
        </TouchableOpacity>
      </View>

      <View style={styles.textView}>
        <Text style={styles.text}>HI USER</Text>
      </View>

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
  imgBackground: {
    flex: 1,
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    paddingHorizontal: 15,
    width: '105wp',
    height: 150,
    resizeMode: 'cover',
    color: 'rgba(163, 163, 163, 0.8)',
  },

  textView: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    marginLeft: 15,
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

  profileButton: {
    alignItems: 'center',
    width: 50,
    height: 50,
    resizeMode: 'contain',
  },
});

export default Header;
