<template>
  <div class="funnel-view">
    <span>
      <img src="../assets/funnel/savvy.png" alt="Savvy logo" width="50" />
      <span>Jeans</span>
    </span>
    <div class="product-container">
      <product
        v-if="!loading"
        :price="displayedProduct.price"
        :brand="displayedProduct.brand"
        :productImage="displayedProduct.image"
      />
    </div>
    <span>
      <button v-on:click="rateProduct(false)">X</button>
      <button v-on:click="rateProduct(true)">V</button>
    </span>

    <p>
      numrated {{numRatedProducts}}
  <br>
      isnew {{isNew}}
        <br>
      userId {{userId}}
    </p>
  </div>
</template>

<script>

/*eslint-disable*/

import Product from '@/components/Product.vue';
import { httpService as http } from '@/services/http';
import { mapState, mapGetters, mapActions } from 'vuex';

export default {
  name: 'funnel',

  data() {
    return {
      displayedProduct: {},
      loading: false,
      products: []
    };
  },

  components: {
    product: Product
  },

  computed: {
    ...mapState('user', ['isNew', 'numRatedProducts', 'userId']),
    ...mapGetters('user', ['seenEnough']),
  },

  created() {
    this.fetchProducts();
  },

  methods: {
    async fetchProducts() {
      this.loading = true;
      const productsShow = this.$store.state.user.productsShow;
      this.products = await http.fetchProducts(productsShow);
      this.popProduct();
      this.loading = false;
    },

    popProduct() {
      if (this.products.length > 0) {
        const {meta: p, product_id} = this.products.pop();
        this.displayedProduct = {
          id: product_id,
          price: p.price,
          brand: p.brand,
          image: p.images[0]
        };
      } else {
        this.displayedProduct = {};
        this.routeForward();
      }
    },

    rateProduct(rating) {
      console.log(this.numRatedProducts);
      this.$store.commit('user/setNumRatedProducts', this.numRatedProducts + 1);
      console.log(this.numRatedProducts);
      http.rateProduct(this.displayedProduct.id, rating);
      if(this.seenEnough){
        this.routeForward()
      } else {
        this.popProduct()
      }
    },

    routeForward() {
      const path = this.isNew ? 'funnel/summary' : 'closet';
      this.$router.push(path)
    },
  }
};
</script>

<style>
.funnel-view {
  background: lightsalmon;
}
</style>