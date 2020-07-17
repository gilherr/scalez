<template>
  <div class="closet-view">
    <h1 v-if="loading">Loading...</h1>
    <h1>Closet</h1>

    <div class="filters">
      icon icon icon icon
    </div>

    <div class="products-list">
        <product
            v-for="product in products"
            v-bind:key="product.id"
            :price="product.price"
            :productImage="product.image"
          />
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
      }))
      this.loading = false;
    },

    routeForward() {
      const path = this.seenEnough ? '/closet' : '/funnel';
      this.$router.push(path)
    },
  },
};
</script>