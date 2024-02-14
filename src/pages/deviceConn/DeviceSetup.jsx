import { StyleSheet, Text, View } from 'react-native'
import React from 'react'
import AcTextField from '../../components/TextField'
import AcButton from '../../components/Button'
import {widthPercentageToDP as wp, heightPercentageToDP as hp} from 'react-native-responsive-screen';
import SubFooter from '../../components/SubFooter';
import SubHeader from '../../components/SubHeader';


const DeviceSetup = () => {
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

export default DeviceSetup

const styles = StyleSheet.create({
    container:{
        display:'flex',
        height: hp('100%'),
        width: wp('100%'),
      },
})