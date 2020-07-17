<template>
  <div class="summary-view">
    <h1>Savvy</h1>
    <p>to qualify, please make sure to</p>

    <div class="shadow-block">
      <div>
        <h2>Like at least {{minLikedProducts}} items</h2>
        <p v-if="seenEnough">(You already have the items)</p>
        <p v-else>(You currently have {{numRatedProducts}})</p>
      </div>
      <div class="heart">Heart</div>
    </div>

    <p>So i understand your style better!</p>

    <button v-on:click="routeForward">Next</button>
  </div>
</template>

<script>
import { mapState, mapGetters } from 'vuex';

export default {
  name: 'Summary',

  computed: {
    ...mapState('user', ['numRatedProducts', 'minLikedProducts']),
    ...mapGetters('user', ['seenEnough'])
  },
  
  methods: {
    routeForward() {
      const path = this.seenEnough ? '/closet' : '/funnel';
      this.$router.push(path)
    },
  },
};
</script>