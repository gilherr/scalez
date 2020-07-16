<template>
  <div class="tester-view">
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
        <input type="number" name="isNewUser" v-model="formData.user.productsShow" />
      </p>
      <p>
        <label for="minLiked">Minimum liked products before closet</label>
        <input type="number" name="minLiked" max="17" v-model="formData.user.minLikedProducts" />
      </p>

      <p>
        <input type="submit" value="Start" />
      </p>
    </form>
  </div>
</template>

<script>
import { httpService as http } from '@/services/http';
import { mapState } from 'vuex';

export default {
  name: 'Tester',


  data() {
    return {
      formData: {
        user: {},
      },
      loading: false,
      availableUsers: []
    };
  },


  created() {
    this.formData.user = this.$cookies.get('userMeta') || {};
    this.fetchUsers();
  },

  methods: {
    async fetchUsers() {
      this.loading = true;
      const response = await http.fetchAllUsers('/users');
      this.loading = false;
      this.availableUsers = response ? response : [];
    },

    onSubmit(e) {
      e.preventDefault();

      const userMeta = this.formData.user;

      this.$store.dispatch('user/setUserFromCookie', userMeta)
      this.$cookies.set('userMeta', JSON.stringify(userMeta));
      http.updateUserMeta(userMeta);
      
      this.$router.push('home')
    },

  },


  computed: {
    ...mapState('user', ['userId', 'isNew', 'productsShow', 'minLikedProducts'])
  }


};
</script>
