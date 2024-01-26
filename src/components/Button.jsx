import { StyleSheet,View, Text } from 'react-native'
import React from 'react'
import { TouchableOpacity } from 'react-native-gesture-handler'

const Button = ({ children }) => {
  return <View style={styles.button}>{children}</View>;
};
export const ActionButton = ({
  text,
  onPress,
  color = styles.formbt.color,
  fw = styles.formbt.fontWeight,
  size = styles.formbt.size,
  hp = 0,
  vp = 0,
}) => {
  return (
    <Button onPress={onPress}>
      <Text
        style={{
          color: color,
          fontWeight: fw,
          fontSize: size,
          paddingHorizontal: hp,
          paddingVertical: vp,
        }}
      >
        {text}
      </Text>
    </Button>
    
  );
};

const styles = StyleSheet.create({
  button: {
    width:240,
    height:45,
    paddingHorizontal: 20,
    paddingVertical: 5,
    borderRadius: 50,
    backgroundColor: "#0F9F4A",
    wordWrap: 'break-word'

  },
  formbt: {
    color: "#fff",
    fontWeight: 700,
    fontFamily: 'Inter',
    size: 24,
    
  },
  text:{
    color:"white",
    fontSize:18,
  },
  touchable:{
    backgroundColor:'green',
    alignItems:'center',
  },
});
