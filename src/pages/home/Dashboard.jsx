import React from 'react';
import { View, Button, StyleSheet } from 'react-native';
import Header from '../../components/header';
import { useNavigation } from '@react-navigation/native';

const HomeScreen = () => {
  const Dashboard = useNavigation();

  const openDrawer = () => {
    navigation.openDrawer();
  };

  return (
    <View style={styles.container}>
      {/* Header */}
      <Header onPressMenu={openDrawer} />

      {/* Body */}
      <View style={styles.body}>
        {/* Body content goes here */}
      </View>

      {/* Footer */}
      <View style={styles.footer}>
       
      </View>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    flexDirection: 'column',
  },
  body: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },
  footer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },
});

export default HomeScreen;
