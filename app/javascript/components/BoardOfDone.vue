<template>
  <div class="todo-board">
    <!-- <header>
      TODO List
    </header> -->
      <div class="list-add-form">
        <!-- <div>All: {{ totalCardCount }} tasks</div> -->
      </div>
      <div class="todo-lists">
        <draggable
          :list="lists"
          class="list-index"
          @end="movingList"
          >
          <ListOfDone v-for="list in ownListsOfDone"
            style="margin-top:10px;margin-bottom:50px;"
            class="slide"
            :list="list"
            :key="list.id"
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
    ownListsOfDone() {
       return this.$store.getters['lists/lists'].filter(list=>list.user_id===this.$store.state.auth.user.id&&list.done)
    },
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
</style>

