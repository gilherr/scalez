<template>
  <div class="product-component">
    <div class="spread">
      <span>Styled by {{stylerName}}</span>
      <span>From {{stylerLocation}}</span>
    </div>
    <div class="image">
      <img :src="productImage" alt="Product Image" />
    </div>
    <div class="spread">
      <span>{{price}}</span>
      <span>{{brand}}</span>
    </div>
  </div>
</template>

<script>
import { mapState } from 'vuex';

export default {
  name: 'Product',

  props: {
    price: Number,
    brand: String,
    productImage: String
  },

  computed: {
    ...mapState('global', ['stylerName', 'stylerImg', 'stylerLocation'])
  }
};
</script>

<style lang="scss">
.product-component {
  background: lightgray;
  display: flex;
  flex-direction: column;
}

.spread {
  display: flex;
  justify-content: space-between;
}

.image {
  img {
    max-width: 80%;
  }
}
</style>