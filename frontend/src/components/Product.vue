<template>
  <div class="product-component">
    <div class="image">
      <img :src="productImage" alt="Product Image" />
    </div>
    <div class="spread">
      <span>${{price}}</span>
      <span>{{brand}}</span>
    </div>
  </div>
</template>

<script>
export default {
  name: 'Product',

  props: {
    price: Number,
    brand: String,
    productImage: String
  },

  computed: {
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
    max-height: 300px;
  }
}
</style>