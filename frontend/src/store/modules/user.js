import Vue from 'vue'

const state = {
  userId: null,
  isNew: null,
  productsShow: null,
  minLikedProducts: null
};

const actions = {
  setAllUserData({ commit }, userMeta) {
    const { userId, is_new, productsShow, minLikedProducts } = userMeta;

    Vue.$cookies.set('userMeta', JSON.stringify(userMeta));

    commit('setId', userId);
    commit('setIsNew', is_new);
    commit('setProductsShow', productsShow);
    commit('setMinLikedProducts', minLikedProducts);
  }

};

const mutations = {
  setId(state, payload) {
    state.userId = payload;
  },

  setIsNew(state, payload) {
    state.isNew = payload;
  },

  setProductsShow(state, payload) {
    state.productsShow = payload;
  },

  setMinLikedProducts(state, payload) {
    state.minLikedProducts = payload;
  }
}

export default {
  namespaced: true,
  state,
  mutations,
  actions,
};
