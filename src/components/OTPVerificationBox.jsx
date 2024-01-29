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
          ref={textInputRefs[index]}
          style={styles.input}
          value={digit}
          onChangeText={(value) => handleOtpChange(index, value)}
          keyboardType="numeric"
          maxLength={1}
        />
      ))}
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    width: '80%',
    alignSelf: 'center',
  },
  input: {
    width: 50,
    height: 50,
    borderBottomWidth: 2,
    textAlign: 'center',
    fontSize: 20,
  },
});

export default OTPVerificationBox;

