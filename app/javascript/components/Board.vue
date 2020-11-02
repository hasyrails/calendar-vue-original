<template>
  <div class="todo-board">
    <!-- <header>
      TODO List
    </header> -->
    <div :class="slideRunner" style="font-size:25px;color:#8EB8FF;font-weight:bold;margin-top:150px;">
      {{message}}
    </div>
      <div class="list-add-form"
      v-if="$store.state.auth.user.length!==0&&$store.state.auth.headers.length!==0">
        <!-- <div>All: {{ totalCardCount }} tasks</div> -->
        <ListAdd
        style="margin-top:10px;"
        ></ListAdd>
      </div>
      <div
      v-if="$store.state.auth.user.length!==0&&$store.state.auth.headers.length!==0"
      style="margin-top:10px;margin-left:10px;color:#32CD32;">
        タスク：合計{{totalCardsCount}}個
      </div>
      <div class="todo-lists" style="margin-top:30px;" v-if="$store.state.auth.user.length!==0&&$store.state.auth.headers.length!==0">
        <draggable
          :list="lists"
          class="list-index"
          @end="movingList"
          >
          <List v-for="list in ownLists"
            style="margin-top:10px;margin-bottom:50px;"
            :list="list"
            :key="list.id"
            :list_id="list.id"
            :title="list.title"
            @change="movingCard"
          ></List>
        </draggable>
      </div>
      <div
      v-if="$store.state.auth.user.length!==0&&$store.state.auth.headers.length===0">
        <div style="font-size:20px;margin-left:20px;margin-top:50px;">
          <Cog fillColor="grey"></Cog>をクリックしてカードを予定に追加しましょう！
        </div>
        <div  class="yureru-j"
         style="margin-top:35px;">
          <ArrowRightBold :size="60" fillColor="orange"></ArrowRightBold>
        </div>
      </div>
     <div class="todo-lists" v-if="$store.state.auth.user.length!==0&&$store.state.auth.headers.length===0">
        <List v-for="list in sampleLists"
          style="margin-top:50px;margin-bottom:10px;"
          :list="list"
          :key="list.id"
          :sampleListId="list.sampleListId"
          :title="list.title"
          @change="movingCard"
        ></List>
    </div>
  </div>
</template>

<script>
import ArrowRightBold from 'vue-material-design-icons/ArrowRightBold.vue';
import Cog from 'vue-material-design-icons/Cog.vue';

import draggable from 'vuedraggable'
import ListAdd from './ListAdd'
import List from './List'
import {mapState, mapGetters} from 'vuex'

export default {
  data(){
    return{
    }
  },
  components: {
    draggable,
    ListAdd,
    List,
    ArrowRightBold,
    Cog,
  },
  computed: {
    ...mapState('lists',{
      lists: 'lists'
    }),
    totalCardsCount() {
      return this.$store.getters['cards/cards'].filter(card=>!card.done&&card.user_id===this.$store.getters['auth/user'].id).length
    },
    ownLists() {
       return this.$store.getters['lists/lists'].filter(list=>list.user_id===this.$store.state.auth.user.id)
    },
    sampleLists() {
       return this.$store.getters['lists/sampleLists']
    },
    slideRunner(){
      if(this.$store.getters['auth/user'].length!==0&&this.$store.getters['auth/headers'].length!==0){
        const slideRunner = ['']
        return slideRunner;
      }
      else if(this.$store.getters['auth/user'].length!==0&&this.$store.getters['auth/headers'].length===0){
        const slideRunner = ['']
        return slideRunner;
      }
      else if(this.$store.getters['auth/user'].length===0&&this.$store.getters['auth/headers'].length!==0){
        const slideRunner = ['']
        return slideRunner;
      }
      else if(this.$store.getters['auth/user'].length===0&&this.$store.getters['auth/headers'].length===0){
        const slideRunner = ['']
        slideRunner.push('slide')
        return slideRunner;
      }
    },
    message(){
      const loginInvitationMessage = ''
      if(this.$store.state.auth.user.length===0&&this.$store.state.auth.headers.length===0){
        this.loginInvitationMessage = 'ゲストログインするとお試し機能、ユーザー登録・ログインすると‥!?'
      }
      // if(!this.$store.state.auth.user&&this.$store.state.auth.headers){
      //   this.loginInvitationMessage = ''
      // }
      // if(this.$store.state.auth.user&&!this.$store.state.auth.headers){
      //   this.loginInvitationMessage = ''
      // }
      else{
        this.loginInvitationMessage = ''
      }
      return this.loginInvitationMessage
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
    },
  },
}
</script>

<style scoped>

.slide {
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
}

.todo-board{
  display: flex;
  background: #E0FFF0;
  /* padding: 0 10px; */
  /* width: calc(100% - 40px); */
  width: 170%;
  height: 100vh;
}

.list-add-form{
}

.yureru-j {
    animation: yureru-j 2s infinite;
}
@keyframes yureru-j {
    0% {
        transform: translateX(5px);
    }
    5% {
        transform: translateX(-5px);
    }
    10% {
        transform: translateX(5px);
    }
    15% {
        transform: translateX(-5px);
    }
    20% {
        transform: translateX(5px);
    }
    25% {
        transform: translateX(-5px);
    }
    30% {
        transform: translateX(0px);
    }
}
</style>

