<template>
  <div class="todo-board">
    <!-- <header>
      TODO List
    </header> -->
      <div class="list-add-form">
        <div style="color:#FF9872;">あなたの完遂タスクは</div>
        <div style="display:flex; margin-left:50px;">
          <div class="purun" style="font-size:30px; margin-right:3px;font-weight:900px;color:#FF5F17;">{{ totalCardOfDoneCount }}</div>
          <div style="margin-top:15px;color:#FF9872;">個</div>
        </div>
      </div>
      <div class="todo-lists">
        <draggable
          :list="lists"
          class="list-index"
          @end="movingList"
          >
          <ListOfDone v-for="list in ownLists"
            style="margin-top:10px;margin-bottom:50px;"
            class="slide"
            :list="list"
            :key="list.id"
            :id="list.id"
            :list_id="list.id"
            :title="list.title"
            @change="movingCard"
          ></ListOfDone>
        </draggable>
      </div>
  </div>
</template>

<script>
import draggable from 'vuedraggable'
import ListAdd from './ListAdd'
import ListOfDone from './ListOfDone'
import {mapState} from 'vuex'

export default {
  components: {
    draggable,
    ListAdd,
    ListOfDone,
  },
  computed: {
    ...mapState('lists',{
      lists: 'lists'
    }),
    totalCardCount() {
      return this.$store.getters.totalCardCount
    },
    ownLists() {
       return this.$store.getters['lists/lists'].filter(list=>list.user_id===this.$store.state.auth.user.id)
    },
    totalCardOfDoneCount(){
       return this.$store.getters['cards/cards'].filter(card=>card.user_id===this.$store.state.auth.user.id&&card.done).length
    }
  },
  mounted(){
    this.$store.dispatch('lists/fetchListsAction')
  },
  methods: {
    confirmList(){
      console.log(this.lists)
    },
    movingCard: function() {
      this.$store.dispatch('lists/updateList', { lists: this.lists })
    },
    movingList: function() {
      this.$store.dispatch('lists/updateList', { lists: this.lists })
    }
  }
}
</script>

<style scoped>

/* .slide {
  animation: infinity-loop 10s infinite linear 1s both; 
  position: relative;
  z-index: 1;
}

@keyframes infinity-loop {
  from {
    transform: translateX(0vw);
  }
  to {
    transform: translateX(100vw);
  }
} */

.todo-board{
  display: flex;
  background: #FFEFD5;
  /* padding: 0 10px; */
  /* width: calc(100% - 40px); */
  width: 125%;
  height: 100vh;
}

.list-add-form{
}

.purun {
  animation: purun 0.8s linear 0s 1;
}

@keyframes purun {
  0%   { transform: scale(1.0, 1.0) translate(0%, 0%); }
  15%  { transform: scale(0.9, 0.9) translate(0%, 5%); }
  30%  { transform: scale(1.3, 0.8) translate(0%, 10%); }
  50%  { transform: scale(0.8, 1.3) translate(0%, -10%); }
  70%  { transform: scale(1.1, 0.9) translate(0%, 5%); }
  100% { transform: scale(1.0, 1.0) translate(0%, 0%); }
}
</style>

