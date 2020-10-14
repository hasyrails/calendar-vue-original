const messages = {
  namespaced: true,
  state: {
    userRegisterSuccessMessage: ''
  },
  mutations: {
    setUserRegisterSuccessMessage (state, { userRegisterSuccessMessage, timeout }) {
      state.userRegisterSuccessMessage = userRegisterSuccessMessage
  
      if (typeof timeout === 'undefined') {
        timeout = 3000
      }
  
      setTimeout(() => (state.userRegisterSuccessMessage = ''), timeout)
    }
  },
  actions: {
  },
  getters: {
  },
}

export default messages;
