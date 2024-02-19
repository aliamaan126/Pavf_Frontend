import { Text, TouchableOpacity, StyleSheet } from 'react-native'
import React from 'react'

const AcButton = (props) => {
    const filledBgColor = props.color || "#007260";
    const outlinedColor = "#0F9F4A";
    const bgColor = props.filled ? filledBgColor : outlinedColor;
    const textColor = "white";

    return (
        <TouchableOpacity
            style={{
                ...styles.button,
                ...{ backgroundColor: bgColor },
                ...props.style
            }}
            onPress={props.onPress}
        >
            <Text style={styles.text}>{props.title}</Text>
        </TouchableOpacity>
    )
}

const styles = StyleSheet.create({
    button: {
      width:274,
      height:46,
      borderColor: "#0F9F4A",
      borderRadius: 50,
      alignItems: 'center',
      justifyContent:'center'
      
    },

    text:{
        fontSize: 22,
        fontFamily:'bold',
        color: 'white'
    }
    
})
export default AcButton