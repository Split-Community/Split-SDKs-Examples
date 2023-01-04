export const state = () => ({
   treatment: null
})

export const mutations = {
  SET_TREATMENT(state, treatment){
    state.treatment = treatment
  }
}

export const actions = {
  async nuxtServerInit({ commit }) {
    let client = this.$factory.client();
    await client.ready()
    let treatment  = client.getTreatment('tin.tran+1', 'TestSplit');
  	commit('SET_TREATMENT', treatment);
  }
}
