<template>
  <div class="closet-view">
    <h1 v-if="loading">Loading...</h1>
    <h1>Closet</h1>

    <div class="filters">
      <img src="../assets/closet/filter-icons.png" />
    </div>

    <div class="products-list">
      <div class="product-container"
          v-for="p in products"
          v-bind:key="p.id">
        <product
            
            :price="p.price"
            :productImage="p.image"
            :productName="p.productName"
            :xButton="p.xButton"
          />
      </div>
    </div>

    <div class="next-btn-container">
      <a class="next-btn" v-on:click="restart">Reset & Restart</a>
    </div>

  </div>
</template>

<script>
import { mapState, mapGetters } from 'vuex';
import { httpService as http } from '@/services/http';

import Product from '@/components/Product.vue';



export default {
  name: 'Closet',

  data() {
    return {
      loading: false,
      products: []
    };
  },

  components: {
    product: Product
  },

  computed: {
    ...mapState('user', ['numLikedProducts', 'minLikedProducts','userId']),
    ...mapGetters('user', ['seenEnough'])
  },

  created() {
    this.fetchCloset();
    http.updateUserMeta({userId: this.userId, isNew: false})
    http.endBtnsAbtest('test_a');
  },
  
  methods: {

    async fetchCloset() {
      this.loading = true;
      this.products = await http.fetchCloset();
      this.products = this.products.map(p => ({
          id: p.product_id,
          price: p.meta.price,
          productName: p.meta.productName,
          image: p.meta.images[0],
          xButton: true,
      }))
      this.loading = false;
    },

    async restart() {
      this.$store.dispatch('user/clearUserStore');
      this.$cookies.remove('userMeta');
      this.$cookies.remove('abtests');
      this.$router.push('/')
    },
  },
};
</script>

<style lang="scss">
.closet-view{

  .filters{
    width: 100%;
    img {
      max-width: 100%;
      max-height: 100%;
    }
  }

  .products-list{
    display: flex;
    flex-wrap: wrap;
    .product-container{
      
      padding-top: 20px;
      box-shadow: 4px 5px 11px 2px #0000001c;
      border-radius: 10px;
      margin: 15px;
      width: 160px;
      height: 210px;
      .product-component .image img{
        max-height: 150px;
      }
    }
  }
}
</style>