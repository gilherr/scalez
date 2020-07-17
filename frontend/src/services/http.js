import axios from 'axios';

const http = axios.create({
  baseURL: process.env.VUE_APP_API_URL,
  withCredentials: true
})

export const httpService = {

  async fetchAllUsers() {
    try {
      const response = await http.get('/users');

      response.data.forEach(user => {
        user.minLikedProducts = 5;
        user.productsShow = 3;

        user.userId = user.user_id * 1;
        user.isNew = user.is_new;
        
        delete user.user_id;
        delete user.is_new;
      })

      return response.data.sort((a,b)=>a.userId - b.userId);
    } catch (e) {
      console.error(e);
      return false;
    }
  },

  updateUserMeta({userId, isNew}) {
    try {
      http.put(`/users/${userId}?isNew=${isNew}`);
    } catch (e) {
      console.error(e);
      return false;
    }
  },

  async fetchProducts(productsShow) {
    try {
      const response = await http.get(`funnel/getProducts?productsShow=${productsShow}`);
      return response.data;
    } catch (e) {
      console.error(e);
      return false;
    }
  },

  rateProduct(pid, rating) {
    try {
      http.put(`funnel/rate?productId=${pid}&like=${rating}`);
    } catch (e) {
      console.error(e);
      return false;
    }
  },

}
