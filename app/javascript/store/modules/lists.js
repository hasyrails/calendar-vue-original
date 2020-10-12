import axios from 'axios'

// const savedLists = localStorage.getItem('trello-lists')

const lists = {
  namespaced: true,
  state: {
    // lists: savedLists ? JSON.parse(savedLists): [
      lists: [{
        title: ''
      }]
  },
  mutations: {
    setLists(state, {lists}){
      state.lists = lists
    },
    createList(state, list) {
      state.lists.push(list)
    },
    removelist(state, payload) {
      state.lists.splice(payload.listIndex, 1)
    },
    removeCardFromList(state, payload) {
      state.lists[payload.listIndex].cards.splice(payload.cardIndex, 1)
    },
    updateList(state, payload) {
      state.lists = payload.lists
    }
  },
  actions: {
    async fetchListsAction({ commit }) {
      await axios.get('api/lists')
          .then((response) => {
          commit('setLists', { lists: response.data })
        })
    },
    async createListAction({commit}, list) {
      await axios.post('api/lists', list)
        .then(res => {
          commit('createList', res.data)
        })
        .catch(error => console.log(error.response));
    },
    removelist(context, payload) {
      context.commit('removelist', payload)
    },
    async deleteListAction ({commit}, list) {
      
      await axios.delete('/api/list/' + list.id)
      .then(res => {
        // commit('deleteList');
        commit('removelist',)
              // return true;
          }).catch(error => {
              return error;
          });
  },
    removeCardFromList(context, payload) {
      context.commit('removeCardFromList', payload)
    },
    updateList(context, payload) {
      context.commit('updateList', payload)
    }
  },
  getters: {
    // totalCardCount(state) {
    //   let count = 0
    //   state.lists.map(content => count += content.cards.length)
    //   return count
    // },
    lists: (state) => state.lists,
  },
}

export default lists;
