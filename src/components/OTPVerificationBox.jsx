import React, { useState } from 'react';
import { View, TextInput, StyleSheet } from 'react-native';

const OTPVerificationBox = ({ onOtpFilled }) => {
  const [otp, setOtp] = useState(['', '', '', '']);

  const handleOtpChange = (index, value) => {
    if ((value.length <= 1 && /^[0-9]$/.test(value)) || value === '') {
      const newOtp = [...otp];
      newOtp[index] = value;
      setOtp(newOtp);

      if (value === '' && index > 0) {
        textInputRefs[index - 1].focus();
      } else if (index < 3 && value.length === 1) {
        textInputRefs[index + 1].focus();
      }

      // Notify parent component about OTP filled status
      onOtpFilled(newOtp);
    }
  };

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


// Styles for the OTPVerificationBox component
const styles = StyleSheet.create({
  container: {
    flexDirection: 'row',
    width: '80%', // Adjusted width of the box
    height: 80, // Adjusted height of the box
    alignSelf: 'center',
  },
  input: {
    flex: 1,
    textAlign: 'center',
    fontSize: 20,
    borderWidth: 1,
    borderColor: 'lightgreen',
    borderRadius: 15,
    marginHorizontal: 5,
    backgroundColor: 'lightgreen',
  },
});

export default OTPVerificationBox;
