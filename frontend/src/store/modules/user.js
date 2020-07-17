import Vue from 'vue'

const state = {
  userId: null,
  isNew: null,
  productsShow: null,
  minLikedProducts: null,
  numLikedProducts: 0,
};

const actions = {
  setAllUserData({ commit }, userMeta) {
    const { userId, isNew, productsShow, minLikedProducts } = userMeta;

    Vue.$cookies.set('userMeta', JSON.stringify(userMeta));

    commit('setId', userId);
    commit('setIsNew', isNew);
    commit('setProductsShow', productsShow);
    commit('setMinLikedProducts', minLikedProducts);
  },
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
  },

  setNumLikedProducts(state, payload) {
    state.numLikedProducts = payload;
  }
};

const getters = {
  seenEnough: state => {
    return state.numLikedProducts >= state.minLikedProducts
  }
}

export default {
  namespaced: true,
  state,
  mutations,
  actions,
  getters
};
