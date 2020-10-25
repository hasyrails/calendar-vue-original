import axios from 'axios'

// const savedLists = localStorage.getItem('trello-lists')

const lists = {
  namespaced: true,
  state: {
    // lists: savedLists ? JSON.parse(savedLists): [
      lists: [{
        title: '',
        user_id: ''
      }],
      sampleLists: [
        {
          title: 'sample1',
          user_id: ''
        },
        {
          title: 'sample2',
          user_id: ''
        },
      ]
  },
  mutations: {
    setLists(state, {lists}){
      state.lists = lists
    },
    createList(state, list) {
      state.lists.push(list)
    },
    deleteList(state, payload) {
      state.lists.splice(payload.id, 1)
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
    async deleteListAction ({commit}, payload) {
      await axios.delete('/api/lists/' + payload.id)
      .then(res => {
        commit('deleteList')
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
    sampleLists: (state) => state.sampleLists,
  },
}

export default lists;
