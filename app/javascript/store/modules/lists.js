import axios from 'axios'

// const savedLists = localStorage.getItem('trello-lists')

const lists = {
  namespaced: true,
  state: {
    // lists: savedLists ? JSON.parse(savedLists): [
    lists: [
      {
        title: '',
        cards: [
          { body: '' },
        ]
      },
    ],
  },
  mutations: {
    setLists(state, {lists}){
      state.lists = lists
    },
    addlist(state, payload) {
      state.lists.push({ title: payload.title, cards:[] })
    },
    removelist(state, payload) {
      state.lists.splice(payload.listIndex, 1)
    },
    addCardToList(state, payload) {
      state.lists[payload.listIndex].cards.push({ body: payload.body })
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
    addlist(context, payload) {
      context.commit('addlist', payload)
    },
    removelist(context, payload) {
      context.commit('removelist', payload)
    },
    addCardToList(context, payload) {
      context.commit('addCardToList', payload)
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
