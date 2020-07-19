<template>
  <div class="summary-view">
    <h1>Savvy</h1>
    <p>to qualify, please make sure to</p>

    <div class="shadow-block">

      <div class="text-in-box">
        <div class="larger">Like at least {{minLikedProducts}} items</div>
        <div class="smaller" v-if="seenEnough">(You already have the items)</div>
        <div class="smaller" v-else>(You currently have {{numLikedProducts}})</div>
      </div>

      <div class="heart">
        <img src="@/assets/summary/heart.png" alt="Heart" />
      </div>

    </div>

    <p>So i understand your style better!</p>

    <div class="next-btn-container">
      <a class="next-btn" v-on:click="routeForward">Next</a>
    </div>

  </div>
</template>

<script>
import { mapState, mapGetters } from 'vuex';

export default {
  name: 'Summary',

  computed: {
    ...mapState('user', ['numLikedProducts', 'minLikedProducts']),
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

<style lang="scss">
.summary-view{
  padding: 15px;

  p{
    font-size: larger;
  }

  .shadow-block{
    display: flex;
    justify-content: space-between;
    border-radius: 20px;
    box-shadow: 2px 5px 7px 4px #0000001a;
    padding: 18px 20px;
    margin-bottom: 50px;

    .text-in-box{
      padding-top: 20px;
      .larger{
        font-size: x-large;
      }
      .smaller{
        font-size: medium;
      }
    }
  }

  .next-btn-container {
    display: flex;
    justify-content: center;

    .next-btn{
      background: rgb(248,228,226);
      background: linear-gradient(90deg, rgba(248,228,226,1) 0%, rgba(247,205,200,1) 100%);

      width: 80%;
    }
  }
}
</style>