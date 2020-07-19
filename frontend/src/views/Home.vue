<template>
  <div class="home-view">

    <div class="top-row">
      <div class="img-container">
        <img src="../assets/home/cover.png" alt="Shopping Lady"/>
      </div>
      <h1>Ready to StyleUp?!</h1>
      <p>I'll show you personalized style advice. You tell me which you like. And i'll show you products that match!</p>
    </div>

    <div class="next-btn-container">
      <a class="next-btn" v-on:click="next">Next</a>
    </div>

  </div>
</template>

<script>
import { httpService as http } from '@/services/http';

export default {
  
  name: 'Home',

  created() {

      if(this.isValidQueryParams()){
        const userMeta = this.$route.query;
        this.$store.dispatch('user/setAllUserData', userMeta)
        http.updateUserMeta(userMeta);
      } else {
        this.$router.push('/')
      }

  },

  methods: {

    isValidQueryParams() {
      const params = this.$route.query;
      return 'userId' in params &&
              'isNew' in params &&
              'productsShow' in params &&
              'minLikedProducts' in params
    },

    next() {
      this.$router.push('funnel')
    }

  }
};
</script>

<style lang="scss">
.home-view {
  display: flex;
  flex-flow: column;
  justify-content: space-between;
  text-align: center;
  height: 100%;
}

.img-container{
  width: 100%;
    img{
      max-width:100%;
      max-height:100%;
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

</style>