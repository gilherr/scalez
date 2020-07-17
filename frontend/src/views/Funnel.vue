<template>
  <div class="funnel-view">
    <div class="header-row">
      <img src="../assets/funnel/savvy.png" alt="Savvy logo" />
      <div class="tag btn pill">
        <img src="../assets/funnel/jeans_icon.png" />
        <div>Jeans</div>
      </div>
    </div>


    <div class="product-container">
      <div class="styler-header">
        <div class="styler-name-avatar">
          <img src="@/assets/funnel/stylerImg.png" alt="Styler Image" />
          <div>Styled by <b>{{stylerName}}</b></div>
        </div>
        <div>from <b>{{stylerLocation}}</b></div>
      </div>

      <div class="main-component">
        <product
          v-if="!loading"
          :price="displayedProduct.price"
          :brand="displayedProduct.brand"
          :productImage="displayedProduct.image"
        />
      </div>
    </div>


    <div class="btns-container">
      <a class="btn dislike" v-on:click="rateProduct(false)">
        <img src="@/assets/funnel/x.png" alt="Styler Image" />
        </a>
      <a class="btn like" v-on:click="rateProduct(true)">
        <img src="@/assets/funnel/heart.png" alt="Styler Image" />
        </a>
    </div>
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
    ...mapState('user', [ 'isNew', 'numLikedProducts', 'userId', 'productsShow' ]),
    ...mapState('global', ['stylerName', 'stylerImg', 'stylerLocation']),
    ...mapGetters('user', ['seenEnough'])
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
        const { meta: p, product_id } = this.products.pop();
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
      if (rating === true)
        this.$store.commit(
          'user/setNumLikedProducts',
          this.numLikedProducts + 1
        );
      http.rateProduct(this.displayedProduct.id, rating);

      if (this.seenEnough) {
        this.routeForward();
      } else {
        this.popProduct();
      }
    },

    routeForward() {
      const path = this.isNew ? '/funnel/summary' : '/closet';
      this.$router.push(path);
    }
  }
};
</script>

<style lang="scss">
.funnel-view {
  display: flex;
  flex-flow: column;
  justify-content: space-between;
  text-align: center;
  height: 98%;

  .header-row {
    display: flex;
    justify-content: space-between;
    margin: 25px 15px;
    height: 35px;

    img {
      max-height: 30px;
    }

    .tag {
      background: #f7f7fa;
      margin: unset;
      padding: unset;
      font-size: small;
      display: flex;
      justify-content: center;
      align-items: center;
      width: 100px;

      img {
        padding-right: 8px;
        height: 20px;
      }
    }
  }

  .product-container {
    box-shadow: 4px 5px 11px 2px #00000038;
    border-radius: 25px;
    margin: 0px 15px;
    flex-grow: 1;
    height: 300px;

    .styler-header{
      display: flex;
      justify-content: space-between;
      height: 15%;
      margin: 0 15px;
      align-items: center;

      .styler-name-avatar {
        display: flex;
        align-items: center;
        
        img{
          width: 35px;
          margin-right: 10px;
        }
      }
    }

    .main-component{
      height: 85%;
    }
  }

  .btns-container {
    flex-grow: 1;
    display: flex;
    justify-content: space-around;
    align-items: center;

    .btn{
      padding: 25px;
      text-align: center;
      text-decoration: none;
      display: inline-block;
      cursor: pointer;
      border-radius: 50%;

      img{
        height: 50px;
      }
    }

    .btn.dislike:active,
    .btn.like:active{
      border-color: #ffca00c7;;
    }

    .btn.dislike{
      border: 5px solid #efedf2;
      color: #5e80b7;
      box-shadow: 6px 4px 14px 3px #5e80b766;
    }

    .btn.like{
      border: 5px solid #fff1f0;
      color: #5e80b7;
      box-shadow: 6px 4px 14px 3px #f8cec8;
    }
  }
}
</style>