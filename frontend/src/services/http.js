import axios from 'axios';

const http = axios.create({
  baseURL: process.env.VUE_APP_API_URL,
  withCredentials: true
})

export const httpService = {

  async fetchAllUsers() {
    try {
      const response = await http.get('/users');
      return response.data.sort((a,b)=>a.user_id - b.user_id);
    } catch (e) {
      console.error(e);
      return false;
    }
  },

  updateUserMeta(user_id, is_new) {
    try {
      http.put(`/users/${user_id}?isNew=${is_new}`);
    } catch (e) {
      console.error(e);
      return false;
    }
  }

}
