import React from 'react';
import { View, ScrollView, StyleSheet } from 'react-native';
import Header from '../../components/header';
import View_Rreadings from '../../components/View_Rreadings';

const DashBoard = ({ navigation }) => {
  return (
    <ScrollView style={styles.container}>
      {/* Header */}
      <Header />

      {/* Body */}
      <View_Rreadings />
      
      {/* Footer */}
      <View style={styles.footer}>
        {/* Footer content goes here */}
      </View>
    </ScrollView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    flexDirection: 'column',
  },
  footer: {
    justifyContent: 'center',
    alignItems: 'center',
  },
});

export default DashBoard;
