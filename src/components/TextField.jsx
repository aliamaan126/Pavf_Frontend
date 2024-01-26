import { View, TextInput } from 'react-native';
import React from 'react';

const TextField = ({ children }) => {
  return <View style={textFieldStyles.container}>{children}</View>;
};

export const ActionTextField = ({
  placeholder,
  value,
  onChangeText,
  color = textFieldStyles.formField.color,
  bgcolor = textFieldStyles.container.backgroundColor,
  bcolor = textFieldStyles.container.borderColor,
  fw = textFieldStyles.formField.fontWeight,
  size = textFieldStyles.formField.size,
  hp = 0,
  vp = 0,
}) => {
  return (
    <TextField>
      <TextInput
        placeholder={placeholder}
        value={value}
        onChangeText={onChangeText}
        style={{
          color: color,
          backgroundColor:bgcolor,
          borderColor:bcolor,
          fontWeight: fw,
          fontSize: size,
          paddingHorizontal: hp,
          paddingVertical: vp,
        }}
      />
    </TextField>
  );
};

const textFieldStyles = {
  container: {
    width:300 ,
    height:55,
    paddingHorizontal: 18,
    paddingVertical: 15,
    borderRadius: 20,
    backgroundColor: "white",
    borderWidth: 1,
    borderColor: "black",
    marginTop: 14,
    marginBottom: 14,
  },
  formField: {
    color: "black",
    fontWeight: "400", // React Native uses string values for fontWeight
    fontFamily: 'Inter',
    fontsize: 18,
  },
};
