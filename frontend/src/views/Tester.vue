<template>
  <div class="tester">
    <div v-if="loading" class="loading">Loading...</div>

    <h1>Tester Page</h1>

    <form @submit="onSubmit">
      <p>
        <label for="userSelect">Select User</label>
        <select name="userSelect" id="userSelect" v-model="formData.user">
          <option
            v-for="user in availableUsers"
            :value="user"
            v-bind:key="user.user_id"
          >{{user.user_id}}</option>
        </select>
      </p>
      <p>
        <label for="isNewUser">New user?</label>
        <input type="checkbox" name="isNewUser" v-model="formData.user.is_new" />
      </p>
      <p>
        <label for="isNewUser">Number of products to show</label>
        <input type="number" name="isNewUser" v-model="formData.productsShow" />
      </p>
      <p>
        <label for="minLiked">Minimum liked products before closet</label>
        <input type="number" name="minLiked" max="17" v-model="formData.minLikedProducts" />
      </p>

      <p>
        <input type="submit" value="Submit" />
      </p>
    </form>
  </div>
</template>

<script>
import { httpService as http } from "../services/http";
import { mapState } from "vuex";

export default {
  name: "Tester",


  data() {
    return {
      formData: {
        user: {},
        minLikedProducts: 5,
        productsShow: 3
      },
      loading: false,
      availableUsers: []
    };
  },


  created() {
    this.formData.user = this.$cookies.get("userMeta") || {};
    this.fetchUsers();
  },


  methods: {
    async fetchUsers() {
      this.loading = true;
      const response = await http.fetchAllUsers(`/users`);
      this.loading = false;
      this.availableUsers = response ? response : [];
    },

    onSubmit(e) {
      e.preventDefault();
      this.updateUserInStore();
      this.setUserMetaInCookie();
      this.updateUserMeta();
    },

    updateUserInStore() {
      const {user_id, is_new, productsShow, minLikedProducts} = this.formData.user;
      this.$store.commit(`user/setId`, user_id);
      this.$store.commit(`user/setIsNew`, is_new);
      this.$store.commit(`user/setProductsShow`, productsShow);
      this.$store.commit(`user/setMinLikedProducts`, minLikedProducts);
    },

    setUserMetaInCookie() {
      const { user_id, is_new } = this.formData.user;
      this.$cookies.set("userMeta", JSON.stringify({ user_id, is_new }));
    },

    updateUserMeta() {
      const {user_id, is_new} = this.formData.user;
      http.updateUserMeta(user_id, is_new);
    }
  },


  computed: {
    ...mapState("user", ["userId", "isNew", "productsShow", "minLikedProducts"])
  }


};
</script>
