const state = {
  userId: null,
  isNew: null,
  productsShow: null,
  minLikedProducts: null
};

const actions = {
  setUserFromCookie({ commit }, userMetaCookie) {
    const { user_id, is_new, productsShow, minLikedProducts } = userMetaCookie;
    commit('setId', user_id*1);
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
