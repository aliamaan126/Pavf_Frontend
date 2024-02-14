import { StyleSheet, Text, View } from 'react-native'
import React from 'react'
import AcTextField from '../../components/TextField'
import SubFooter from '../../components/SubFooter'
import AcButton from '../../components/Button'
import SubHeader from '../../components/SubHeader'
import {widthPercentageToDP as wp, heightPercentageToDP as hp} from 'react-native-responsive-screen';


const DeviceWifiCon = () => {
  return (
    <View>
    <SubHeader heading={'Header'} ></SubHeader>
    <Text>Username</Text>
    <AcTextField placeholder={'username'}></AcTextField>
    <Text>Password</Text>
    <AcTextField placeholder={'password'}></AcTextField>
    <AcButton title='Connect'></AcButton>
    <SubFooter></SubFooter>
    </View>
  )
}

export default DeviceWifiCon

const styles = StyleSheet.create({
    container:{
        display:'flex',
        height: hp('100%'),
        width: wp('100%'),
      },
})