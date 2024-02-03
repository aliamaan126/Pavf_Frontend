import React from 'react';
import { View, Text, TouchableOpacity, StyleSheet } from 'react-native';

const drawer = ({ onPressItem }) => {
  return (
    <View style={styles.drawerContainer}>
      <TouchableOpacity onPress={() => onPressItem('Item 1')}>
        <Text style={styles.drawerItem}>Item 1</Text>
      </TouchableOpacity>
      <TouchableOpacity onPress={() => onPressItem('Item 2')}>
        <Text style={styles.drawerItem}>Item 2</Text>
      </TouchableOpacity>
      <TouchableOpacity onPress={() => onPressItem('Item 3')}>
        <Text style={styles.drawerItem}>Item 3</Text>
      </TouchableOpacity>
    </View>
  );
};

const styles = StyleSheet.create({
  drawerContainer: {
    flex: 1,
    backgroundColor: '#fff',
    padding: 20,
    paddingTop: 50,
  },
  drawerItem: {
    fontSize: 18,
    marginBottom: 15,
  },
});

export default drawer;
