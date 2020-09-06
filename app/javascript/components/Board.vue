<template>
  <div>
    <!-- <header>
      TODO List
    </header> -->
    <main>
      <p class="info-line" style="position:fixed;">All: {{ totalCardCount }} tasks</p>
      <div class="list-index">
        <ListAdd
        style="position:fixed;z-index:2;margin-top:100px;"
        ></ListAdd>
        <draggable
          :list="lists"
          class="list-index"
          @end="movingList"
          >
          <List v-for="(item, index) in lists"
                style="z-index:2;margin-top:200px;margin-bottom:50px;"
                class="slide"
                :key="item.id"
                :title="item.title"
                :cards="item.cards"
                :listIndex="index"
                @change="movingCard"
          ></List>
        </draggable>
      </div>
    </main>
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
    ...mapState([
      'lists'
    ]),
    totalCardCount() {
      return this.$store.getters.totalCardCount
    }
  },
  methods: {
    movingCard: function() {
      this.$store.dispatch('updateList', { lists: this.lists })
    },
    movingList: function() {
      this.$store.dispatch('updateList', { lists: this.lists })
    }
  }
}
</script>

<style scoped>

.slide {
  animation: infinity-loop 10s infinite linear 1s both; /* 無限ループアニメーションの設定 */
  position: relative;
}

@keyframes infinity-loop {
  from {
    transform: translateY(0vw);
  }
  to {
    transform: translateY(-50vw);
  }
}
</style>

<>
