import React from 'react';
import { View, Text, StyleSheet, Button } from 'react-native';

const View_Readings = () => {
  const handleViewButtonClick = () => {
    // Add your logic for handling the button click here
    console.log('Button clicked');
  };

  return (
    <View style={styles.container}>
      {/* Four Box Layout with Margin */}
      <View style={styles.fourBoxLayout}>
        <View style={styles.box} />
        <View style={styles.box} />
        <View style={styles.box} />
        <View style={styles.box} />
      </View>

      {/* Visual Recording Heading */}
      <Text style={styles.heading}>Visual Recording</Text>

      {/* Visual Recording Box */}
      <View style={styles.visualRecordingBox}>
        {/* You can add content or components related to visual recording here */}
        <Text style={styles.visualRecordingText}>Visual recording content goes here.</Text>
      </View>

      {/* Heading */}
      <Text style={styles.heading}>View Readings</Text>

      {/* Card Boxes */}
      <View style={styles.cardContainer}>
        {/* Card 1 */}
        <View style={styles.card}>
          {/* Heading */}
          <Text style={styles.cardHeading}>Soil Moisture</Text>

          {/* Text content */}
          <Text style={styles.cardText}>Light Control of the Shelf.</Text>

          {/* Button */}
          <View style={styles.buttonContainer}>
            <Button title="View" onPress={handleViewButtonClick} />
          </View>
        </View>

        {/* Card 2 */}
        <View style={styles.card}>
          {/* Heading */}
          <Text style={styles.cardHeading}>Soil Temp</Text>

          {/* Text content */}
          <Text style={styles.cardText}>Temperature Control of the Shelf.</Text>

          {/* Button */}
          <View style={styles.buttonContainer}>
            <Button title="View" onPress={handleViewButtonClick} />
          </View>
        </View>
         {/* Card 3 */}
         <View style={styles.card}>
          {/* Heading */}
          <Text style={styles.cardHeading}>Soil Temp</Text>

          {/* Text content */}
          <Text style={styles.cardText}>Temperature Control of the Shelf.</Text>

          {/* Button */}
          <View style={styles.buttonContainer}>
            <Button title="View" onPress={handleViewButtonClick} />
          </View>
        </View>
         {/* Card 4 */}
         <View style={styles.card}>
          {/* Heading */}
          <Text style={styles.cardHeading}>Soil Temp</Text>

          {/* Text content */}
          <Text style={styles.cardText}>Temperature Control of the Shelf.</Text>

          {/* Button */}
          <View style={styles.buttonContainer}>
            <Button title="View" onPress={handleViewButtonClick} />
          </View>
        </View>
         {/* Card 5 */}
         <View style={styles.card}>
          {/* Heading */}
          <Text style={styles.cardHeading}>Soil Temp</Text>

          {/* Text content */}
          <Text style={styles.cardText}>Temperature Control of the Shelf.</Text>

          {/* Button */}
          <View style={styles.buttonContainer}>
            <Button title="View" onPress={handleViewButtonClick} />
          </View>
        </View>
         {/* Card 6 */}
         <View style={styles.card}>
          {/* Heading */}
          <Text style={styles.cardHeading}>Soil Temp</Text>

          {/* Text content */}
          <Text style={styles.cardText}>Temperature Control of the Shelf.</Text>

          {/* Button */}
          <View style={styles.buttonContainer}>
            <Button title="View" onPress={handleViewButtonClick} />
          </View>
        </View>
      </View>

      {/* Control Heading */}
      <Text style={styles.heading}>Control</Text>

      {/* Control Card Boxes */}
      <View style={styles.cardContainer}>
        {/* Control Card 1 */}
        <View style={styles.card}>
          {/* Heading */}
          <Text style={styles.cardHeading}>Control 1</Text>

          {/* Text content */}
          <Text style={styles.cardText}>Control 1 description goes here.</Text>

          {/* Button */}
          <View style={styles.buttonContainer}>
            <Button title="View" onPress={handleViewButtonClick} />
          </View>
        </View>
         {/* card 2 */}
        <View style={styles.card}>
          {/* Heading */}
          <Text style={styles.cardHeading}>Control 1</Text>

          {/* Text content */}
          <Text style={styles.cardText}>Control 1 description goes here.</Text>

          {/* Button */}
          <View style={styles.buttonContainer}>
            <Button title="View" onPress={handleViewButtonClick} />
          </View>
        </View>
        {/* Repeat the above pattern for more control cards if needed */}
      </View>
      
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 20,
    backgroundColor: '#f0f0f0',
  },
  fourBoxLayout: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    marginBottom: 20,
  },
  box: {
    width: '23%', // Adjust the width as needed
    height: 40,
    backgroundColor: 'blue', // Adjust color as needed
    borderRadius: 10,
  },
  heading: {
    fontSize: 24,
    fontWeight: 'bold',
    marginBottom: 20,
  },
  visualRecordingBox: {
    width: '100%',
    height: 100,
    backgroundColor: '#F2D4D4',
    borderWidth: 1,
    borderColor: '#e0e0e0',
    borderRadius: 20,
    padding: 10,
    marginBottom: 20,
  },
  visualRecordingText: {
    fontSize: 16,
  },
  cardContainer: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    justifyContent: 'space-between',
  },
  card: {
    width: '48%',
    height: 120,
    backgroundColor: '#C9E9C9',
    marginBottom: 10,
    borderWidth: 1,
    borderColor: '#e0e0e0',
    borderRadius: 20,
    padding: 10,
  },
  cardHeading: {
    fontSize: 18,
    fontWeight: 'bold',
    marginBottom: 5,
  },
  cardText: {
    fontSize: 14,
    marginBottom: 10,
  },
  buttonContainer: {
    alignSelf: 'flex-end',
    marginTop: 'auto',
    width: '100wp',
    // backgroundColor: 'white', // Set background color to white
    // borderRadius: 10, // Optional: Add border radius for rounded corners
    // padding: 5, // Optional: Adjust padding according to your design
    // shadowColor: 'rgba(0, 0, 0, 0.1)', // Set shadow color
    // shadowOffset: { width: 5, height: 2 }, // Set shadow offset
    // shadowOpacity: 0.9, // Set shadow opacity
    // shadowRadius: 4, // Set shadow radius
    // elevation: 5, // Android specific: Set elevation for shadow
  },
});

export default View_Readings;
