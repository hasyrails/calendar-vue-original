<template>
  <div class="todo-board">
    <!-- <header>
      TODO List
    </header> -->
      <div class="list-add-form">
        <div>All: {{ totalCardCount }} tasks</div>
        <ListAdd
        style="margin-top:50px;"
        ></ListAdd>
      </div>
      <div class="todo-lists">
        <draggable
          :list="lists"
          class="list-index"
          @end="movingList"
          >
          <List v-for="(item, index) in lists"
                style="margin-top:50px;margin-bottom:50px;"
                class="slide"
                :key="item.id"
                :id="item.id"
                :title="item.title"
                @change="movingCard"
          ></List>
        </draggable>
      </div>
      <div>
        <div class="btn btn-primary" @click="confirmList"></div>
      </div>
  </div>
</template>

<script>
import draggable from 'vuedraggable'
import ListAdd from './ListAdd'
import List from './List'
import {mapState} from 'vuex'

export default {
  components: {
    draggable,
    ListAdd,
    List
  },
  computed: {
    ...mapState('lists',{
      lists: 'lists'
    }),
    totalCardCount() {
      return this.$store.getters.totalCardCount
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
  animation: infinity-loop 15s infinite linear 1s both; 
  position: relative;
  z-index: 1;
} */

/* @keyframes infinity-loop {
  from {
    transform: translateX(0vw);
  }
  to {
    transform: translateX(100vw);
  }
} */

.todo-board{
  display: flex;
  background: #E0FFF0;
  /* padding: 0 10px; */
  /* width: calc(100% - 40px); */
  width: 125%;
  height: 100%;
  margin-left: 1%;
}

.list-add-form{
  margin-left: 1%;
}
</style>

