const state = {
    userId: null,
    isNew: null,
    productsShow: null,
    minLikedProducts: null
};

const actions = {

};

const mutations = {
    setId(state, payload){
        state.userId = payload;
    },

    setIsNew(state, payload){
        state.isNew = payload;
    },

    setProductsShow(state, payload){
        state.productsShow = payload;
    },

    setMinLikedProducts(state, payload){
        state.minLikedProducts = payload;
    }
}

export default {
    namespaced: true,
    state,
    mutations,
    actions,
};
