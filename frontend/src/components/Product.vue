<template>
  <div class="product-component">

    <div class="image">
      <p v-if="xButton">X</p>
      <img :src="productImage" alt="Product Image" />
    </div>

    <div class="bottom-row">
      <div><b>${{price}}</b></div>
      <div>{{brand}}</div>
    </div>

    <div>{{productName}}</div>

  </div>
</template>

<script>
export default {
  name: 'Product',

  props: {
    price: Number,
    brand: String,
    productImage: String,
    productName: String,
    xButton: Boolean,
  },

  computed: {
  }
};
</script>

<style lang="scss">
.product-component {
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  height: 100%;
  width: 100%;

  .bottom-row {
    display: flex;
    justify-content: space-between;
    align-items: flex-end;
    margin: 20px;
    height: 15%;
  }

  .image {
    height: 85%;
    margin: 0 20px;

    position:relative;
    display:inline-block;
    img {
      // display:block;
      max-width: 100%;
      max-height: 100%;
    }

  }

  .image:after{
    content:'';
    position:absolute;
    left:0; top:0;
    width:100%;
    height:100%;
    display:inline-block;
    background: linear-gradient(0deg, rgba(255,255,255,1) 0%, rgba(255,255,255,0) 15%, rgba(255,255,255,0) 85%, rgba(255,255,255,1) 100%);
    filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#002f4b', endColorstr='#00000000',GradientType=0 ); /* IE6-9 */
  }



}


</style>