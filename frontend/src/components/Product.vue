<template>
  <div class="product-component">

    <div class="image">
      <div class="x-btn" v-if="xButton">x</div>
      <img :src="productImage" alt="Product Image" />
    </div>

    <div class="bottom-row">
      <div><b>${{price}}</b></div>
      <div v-if="brand">{{brand}}</div>
      <div v-if="productName" class="name">{{productName}}</div>
    </div>


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
    .name{
      overflow: hidden;
      white-space: nowrap;
      margin-left: 20px;
    }
  }

  .image {
    height: 85%;
    margin: 0 20px;

    position:relative;
    display:inline-block;
    .x-btn{
      position: absolute;
      top: 10px;
      right: 0;
      background: #ffffff42;
      padding: 3px 8px;
      text-align: center;
      text-decoration: none;
      display: inline-block;
      cursor: pointer;
      border-radius: 50%;
      box-shadow: 1px 2px 5px 0px #0000006e;
    }
    img {
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