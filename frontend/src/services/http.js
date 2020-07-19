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

  clearRatings() {
    try {
      http.get('/users/truncateRatings');
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

  async fetchCloset() {
    try {
      const response = await http.get('closet');
      return response.data;
    } catch (e) {
      console.error(e);
      return false;
    }
  },

  async startBtnsAbtest(abtestName) {
    try {
      const response = await http.put(`/abtest/start/${abtestName}`);
      return response.data;
    } catch (e) {
      console.error(e);
      return false;
    }
  },

  async endBtnsAbtest(abtestName) {
    try {
      const response = await http.get(`/abtest/end/${abtestName}`);
      return response.data;
    } catch (e) {
      console.error(e);
      return false;
    }
  },

}
