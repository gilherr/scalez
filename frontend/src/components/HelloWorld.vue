<template>
  <div class="helloworld">
    <h1>Example Component</h1>
    <p>{{msg}}</p>
  </div>
</template>

<script>
export default {
  name: "HelloWorld",
  props: {
    msg: String
  }
};
</script>

<style>
.helloworld {
  border: 1px solid;
  background: lightgray;
}
p {
  color: blue;
}
</style>