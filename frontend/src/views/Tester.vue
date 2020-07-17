<template>
  <div class="tester-view">
    <div v-if="loading" class="loading">Loading...</div>

    <h1>Tester Page</h1>

    <form @submit="onSubmit">
      <div class="spread">
        <label for="userSelect">Select User</label>
        <select name="userSelect" id="userSelect" v-model="formData.user">
          <option
            v-for="user in availableUsers"
            :value="user"
            v-bind:key="user.userId"
          >{{user.userId}}</option>
        </select>
      </div>
      <div class="spread">
        <label for="isNewUser">New user?</label>
        <input type="checkbox" name="isNewUser" v-model="formData.user.isNew" />
      </div>
      <div class="spread">
        <label for="isNewUser">Number of products to show</label>
        <input type="number" name="isNewUser" v-model="formData.user.productsShow" />
      </div>
      <div class="spread">
        <label for="minLiked">Mini liked products</label>
        <input type="number" name="minLiked" max="17" v-model="formData.user.minLikedProducts" />
      </div>

      <div class="submit-btn">
        <input type="submit" value="Start" />
      </div>
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
      this.$router.push({ path: '/home', query: this.formData.user })
    },

  },


  computed: {
    ...mapState('user', ['userId', 'isNew', 'productsShow', 'minLikedProducts'])
  }


};
</script>

<style lang="scss" scoped>
.spread{
  display: flex;
  justify-content: space-between;
  margin-bottom: 20px;
  input{
    width: 100px;
  }
}

#userSelect{
  width: 110px;
}

.submit-btn {
  display: flex;
  justify-content: center;
  margin-top: 50px;
}
</style>