import axios from 'axios'

// const savedLists = localStorage.getItem('trello-lists')

const cards = {
  namespaced: true,
  state: {
    // lists: savedLists ? JSON.parse(savedLists): [
    cards: [
      {
        id: '',
        list_id: '',
        body: '',
        description: '',
        status: '',
        scheduled: '',
        // cards: [
        //   { description: '' },
        // ]
      },
    ],
  },
  mutations: {
    setCards(state, {cards}){
      state.cards = cards
    },
    updateCard(state, {card,updateCard}){
      // const index = state.cards.findIndex(card => {
      //   return card.id === updateCard.id
      // })
      //   state.cards.splice(index, 1, updateCard)
      Object.assign(card, updateCard);
    },
     deleteCard(state, index) {
        state.cards.splice(index, 1);
    },
    createCard(state, payload) {
      state.cards.push({ body: payload.body, list_id: payload.list_id })
    },
    // removelist(state, payload) {
    //   state.lists.splice(payload.listIndex, 1)
    // },
    // addCardToList(state, payload) {
    //   state.lists[payload.listIndex].cards.push({ body: payload.body })
    // },
    // removeCardFromList(state, payload) {
    //   state.lists[payload.listIndex].cards.splice(payload.cardIndex, 1)
    // },
    // updateList(state, payload) {
    //   state.lists = payload.lists
    // }
  },
  actions: {
    async fetchCardsAction({ commit }) {
      await axios.get('api/cards')
          .then((response) => {
          commit('setCards', { cards: response.data })
        })
    },
    // async updateCardAction( { commit }, card ) {
    //   await axios.post('api/cards/' ,card)
    //     .then(res => {
    //       commit('updateCard', res.data)
    //     })
    //     .catch(error => console.log(error.response));
    // },
    async updateCardAction ({state, commit}, updateCard) {
      // stateからマッチしたtaskを取り出す
      const card = state.cards.find((o) => {
          return o.id === updateCard.id;
      });

      if (!card) {
          return false;
      }

      return await axios.patch('/api/cards/' + updateCard.id, updateCard)
          .then(res => {
              commit('updateCard', {card, updateCard});
              return true;
          }).catch(error => {
              return error;
          });
    },
    async createCardAction( { commit }, card ) {
      await axios.post('api/cards',card)
        .then(res => {
          commit('createCard', card)
        })
      .catch(error => console.log(error.response));
    },
    // removelist(context, payload) {
    //   context.commit('removelist', payload)
    // },
    // addCardToList(context, payload) {
    //   context.commit('addCardToList', payload)
    // },
    // removeCardFromList(context, payload) {
    //   context.commit('removeCardFromList', payload)
    // },
    // updateList(context, payload) {
    //   context.commit('updateList', payload)
    // }
     async deleteCardAction ({state, commit}, card) {
        const index = state.cards.indexOf(card);
 
        return await axios.delete('/api/cards/' + card.id)
            .then(res => {
                commit('deleteCard', index);
                return true;
            }).catch(error => {
                return error;
            });
    },
  },
  getters: {
    // totalCardCount(state) {
    //   let count = 0
    //   state.lists.map(content => count += content.cards.length)
    //   return count
    // },
    cards: (state) => state.cards,
  },
}

export default cards;
