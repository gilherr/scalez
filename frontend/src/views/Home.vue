<template>
  <div class="home">
    <h1>Hello {{userName}}</h1>
    <HelloWorld msg="Welcome to Your Vue.js App" />
  </div>
</template>

<script>
import { mapState } from "vuex";
import HelloWorld from "../components/HelloWorld";

export default {
  name: "Home",
  components: {
    HelloWorld
  },
  computed: {
    ...mapState("user", {
      userName: state => state.name
    })
  }
};
</script>
