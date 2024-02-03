import React, { useState } from 'react';
import { View, TextInput, StyleSheet } from 'react-native';

const OTPVerificationBox = () => {
  const [otp, setOtp] = useState(['', '', '', '']);

  const handleOtpChange = (index, value) => {
    if (value.length <= 1 && /^[0-9]$/.test(value)) {
      const newOtp = [...otp];
      newOtp[index] = value;
      setOtp(newOtp);

      // Move to the next input field automatically
      if (index < 3 && value.length === 1) {
        textInputRefs[index + 1].focus();
      }
    }
  };

  // Array to store references to text input fields
  const textInputRefs = Array(4)
    .fill(null)
    .map((_, index) => React.createRef());

  return (
    <View style={styles.container}>
      {otp.map((digit, index) => (
        <TextInput
          key={index}
          ref={(ref) => (textInputRefs[index] = ref)}
          style={[styles.input, index !== 3 && { marginRight: 5 }]}
          value={digit}
          onChangeText={(value) => handleOtpChange(index, value)}
          keyboardType="numeric"
          maxLength={1}
          onSubmitEditing={() => {
            if (index < 3) {
              textInputRefs[index + 1].focus();
            }
          }}
        />
      ))}
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flexDirection: 'row',
    width: '80%', // Adjusted width of box
    height:80, // adjust hight of box
    alignSelf: 'center',
   
   
  },
  input: {
    flex: 1,
    textAlign: 'center',// set text in center
    fontSize: 20, // set font size
    borderWidth: 1,// set width for border
    borderColor: 'lightgreen',
    borderRadius: 15,// set border
    marginHorizontal: 5,// set horizental
    backgroundColor: 'lightgreen', // Set the background color
  },
  
});


export default OTPVerificationBox;
