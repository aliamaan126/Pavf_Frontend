import React from 'react';
import { View, TextInput, StyleSheet } from 'react-native';

const AcTextField = ({
  placeholder,
  value,
  onChangeText,
  color,
  backgroundColor,
  borderColor,
  fontWeight,
  fontSize,
  paddingHorizontal,
  paddingVertical,
}) => {
  return (
    <View style={[
      styles.container,
      { backgroundColor, borderColor },
    ]}>
      <TextInput
        placeholder={placeholder}
        value={value}
        onChangeText={onChangeText}
        placeholderTextColor={color}
        style={{
          color,
          fontWeight,
          fontSize,
          paddingHorizontal,
          paddingVertical,
        }}
      />
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    width: 300,
    height: 55,
    paddingHorizontal: 18,
    paddingVertical: 15,
    borderRadius: 10,
    borderWidth: 1,
    marginBottom: 10,
  },
});

export default AcTextField;
