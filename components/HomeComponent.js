import React, { Component } from "react";
import { Text, ScrollView, View } from "react-native";
import { Card } from "react-native-elements";
import { PROMOTIONS } from "../shared/promotions";

function RenderItem(props) {
  const item = props.item;

  if (item != null) {
    return (
      <Card
        featuredTitle={item.name}
        featuredSubtitle={item.designation}
        image={require("./images/icon.jpg")}
      >
        <Text style={{ margin: 10 }}>{item.description}</Text>
      </Card>
    );
  } else {
    return <View></View>;
  }
}

class Home extends Component {
  constructor(props) {
    super(props);
    this.state = {
      promotions: PROMOTIONS,
    };
  }

  static navigationOptions = {
    title: "Home",
  };

  render() {
    return (
      <ScrollView>
        <RenderItem
          item={this.state.promotions.filter((promo) => promo.featured)[0]}
        />
      </ScrollView>
    );
  }
}

export default Home;
