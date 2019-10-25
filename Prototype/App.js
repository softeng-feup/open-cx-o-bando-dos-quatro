/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow
 */

import React, { Component } from 'react';
import { View,ScrollView, Image, Text,StyleSheet , Dimensions,Button} from 'react-native';
import { PanoramaView } from "@lightbase/react-native-panorama-view";


export default class HelloWorldApp extends Component {



  render() {
    const styles = StyleSheet.create({
      container: {
        flex: 1
      },
      viewer: {
        height: 300
      },
      red: {
        color: 'red',
      },
    });
    return (
       
      <View style={styles.container}>

        <PanoramaView
          style={styles.viewer}
          dimensions={{ height: 230, width: Dimensions.get("window").width }}
          inputType="mono"
          //imageUrl="https://upload.wikimedia.org/wikipedia/commons/5/5c/Nyn%C3%A4shamn_NE_Equirectangular_360_panoramic_%2821205394981%29.jpg"
          //imageUrl="/home/tgusta/TesteApp/images/test_image.jpg"
          imageUrl ="https://www.worldphoto.org/sites/default/files/Mohammad%20Reza%20Domiri%20Ganji%2C%20Iran%20%2C%20Shortlist%2C%20Open%2C%20Panoramic%2C%202015%20Sony%20World%20Photography%20Awards%20%282%29.jpg"
        />

        <Text style={styles.red}>just red</Text>

        <View style={styles.alternativeLayoutButtonContainer}>
          <Button
            onPress={this._onPressButton}
            title="Img2!"
          />
          <Button
            onPress={this._onPressButton}
            title="Img3!"
            color="#841584"
          />
        </View>
      </View>
    );
  }
}