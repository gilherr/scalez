<template>
  <div class="home-view">
    <img src="../assets/home/cover.png" alt="Shopping Lady" width="300" />
    <h1>Ready to StyleUp?!</h1>
    <p>I'll show you personalized style advice. You tell me which you like. And i'll show you products that match!</p>
    <button v-on:click="next">Next</button>
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