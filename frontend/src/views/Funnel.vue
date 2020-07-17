<template>
  <div class="funnel-view">
    <span>
      <img src="../assets/funnel/savvy.png" alt="Savvy logo" width="50" />
      <span>Jeans</span>
    </span>
    <div class="product-container">
      <div class="spread">
        <img src="@/assets/funnel/stylerImg.png" alt="Styler Image" width="50px">
        <span>Styled by {{stylerName}}</span>
        <span>From {{stylerLocation}}</span>
      </div>
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

    <pre>
      numLikedProducts: {{numLikedProducts}},
      productsShow: {{productsShow}},
      isNew: {{isNew}},
      userId: {{userId}}
      displayedProduct: {{displayedProduct}}
    </pre>
  </div>
</template>

<script>
import Product from '@/components/Product.vue';
import { httpService as http } from '@/services/http';
import { mapState, mapGetters } from 'vuex';

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
    ...mapState('user', ['isNew', 'numLikedProducts', 'userId', 'productsShow']),
    ...mapState('global', ['stylerName', 'stylerImg', 'stylerLocation']),
    ...mapGetters('user', ['seenEnough']),
  },

  created() {
    this.fetchProducts();
  },

  methods: {
    async fetchProducts() {
      this.loading = true;
      this.products = await http.fetchProducts(this.productsShow);
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
      if(rating === true)
        this.$store.commit('user/setNumLikedProducts', this.numLikedProducts + 1);
      http.rateProduct(this.displayedProduct.id, rating);

      if(this.seenEnough){
        this.routeForward()
      } else {
        this.popProduct()
      }
    },

    routeForward() {
      const path = this.isNew ? '/funnel/summary' : '/closet';
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