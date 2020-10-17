const messages = {
  namespaced: true,
  state: {
    userRegisterSuccessMessage: '',
    userLoginSuccessMessage: '',
  },
  mutations: {
    setUserRegisterSuccessMessage (state, { userRegisterSuccessMessage, timeout }) {
      state.userRegisterSuccessMessage = userRegisterSuccessMessage
  
      if (typeof timeout === 'undefined') {
        timeout = 3000
      }
  
      setTimeout(() => (state.userRegisterSuccessMessage = ''), timeout)
    },
    setUserLoginSuccessMessage (state, { userLoginSuccessMessage, timeout }) {
      state.userLoginSuccessMessage = userLoginSuccessMessage
  
      if (typeof timeout === 'undefined') {
        timeout = 3000
      }
  
      setTimeout(() => (state.userLoginSuccessMessage = ''), timeout)
    },
  },
  actions: {
  },
  getters: {
  },
}

export default messages;
