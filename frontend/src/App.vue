<template>
  <div id="app">
    <router-view />
  </div>
</template>

<style lang="scss">

html,
body {
  height: 100%;
  margin: 0;
}

#app {
  font-family: Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  padding: 15px 15px 0 15px;
  color:#0d0048;
  height: 98%;
}

@media (min-width: 600px) {
  #app {
    width: 50%;
    margin: 0 auto;
  }
}
</style>
