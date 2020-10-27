<template>
<div>
  <div class="user-info-page" v-if="$store.state.auth.user&&$store.state.auth.headers">
    <div class="user-info">
      <div class="user-info-title">ユーザー情報</div>
      <div class="user-info-content">
        <div class="user-name-item">
          ユーザー名：
        </div>
        <div class="user-name">
          {{ $store.state.auth.user.user.data.name }}さん
        </div>
      </div>
      <div class="user-info-content">
        <div class="user-email-item">
          メールアドレス：
        </div>
        <div class="user-email">
          {{ $store.state.auth.user.user.data.email }}
        </div>
      </div>
      <div class="user-info-content">
        <div class="user-image-item">
          ユーザーアイコン：
        </div>
        <div>
          <div class="user-image" v-if="src">
            <img style="border-radius:50%;" :src="src" width="300" height="300">
          </div>
          <div class="alternative-user-image" v-if="!src">
            <Account :size="120" fillColor="#2C7CFF"></Account>
          </div>
        </div>
      </div>
      <div class="user-info-content">
        <div class="schedulized-cards-item">
          進行中のタスク数：
        </div>
        <div class="schedulized-cards">
        {{ schedulizedCardsCount }}
        </div>
      </div>
      <div class="user-info-content">
        <div class="finished-cards-item">
          期限を護ったタスクの数：
        </div>
        <div class="finished-cards">
        {{ doneCardsCount }}
        </div>
      </div>
      <div class="user-info-content">
        <div class="deadlined-cards-item">
          期限をﾏﾓﾚﾅｶｯﾀ‥タスクの数：
        </div>
        <div class="deadlined-cards">
        {{ deadlinedCardsCount }}
        </div>
      </div>
      <div class="counted-cards">
        合計：{{ countedCardsCount }}
      </div>
      <div class="user-info-content">
        <div class="user-graph-item">
          初志の勝率：
        </div>
        <div class="user-graph purun">
          {{percentage}} 
        </div>
      </div>
      <div class="graph">
        <UserInfoGraph></UserInfoGraph>
      </div>
    </div>
  </div>
  <div class="user-info-page" v-if="$store.state.auth.user&&!$store.state.auth.headers">
    <div class="user-info">
      <div class="user-info-title">ユーザー情報</div>
      <div class="user-info-content">
        <div class="user-name-item">
          ユーザー名：
        </div>
        <div class="user-name">
          {{ $store.state.auth.user.user.name }}さん
        </div>
      </div>
      <div class="user-info-content">
        <div class="user-email-item">
          メールアドレス：
        </div>
        <div class="user-email">
          {{ $store.state.auth.user.user.email }}
        </div>
      </div>
      <div class="user-info-content">
        <div class="user-image-item">
          ユーザーアイコン：
        </div>
        <div class="guest-user-image">
          <Account :size="100" fillColor="#2C7CFF"></Account>
        </div>
      </div>
      <div class="user-info-content">
        <div class="schedulized-cards-item">
          進行中のタスク数：
        </div>
        <div class="guest-schedulized-cards">
          <Key :size="100" fillColor="#FFC7AF"></Key>
        </div>
      </div>
      <div class="user-info-content">
        <div class="finished-cards-item">
          期限を護ったタスクの数：
        </div>
        <div class="guest-finished-cards">
          <Key :size="100" fillColor="#FFC7AF"></Key>
        </div>
      </div>
      <div class="user-info-content">
        <div class="deadlined-cards-item">
          期限をﾏﾓﾚﾅｶｯﾀ‥タスクの数：
        </div>
        <div class="guest-deadlined-cards">
          <Key :size="100" fillColor="#FFC7AF"></Key>
        </div>
      </div>
      <div class="guest-counted-cards">
        合計：<Key :size="100" fillColor="#FFC7AF"></Key>
      </div>
      <div class="user-info-content">
        <div class="user-graph-item">
          初志の勝率：
        </div>
        <div class="guest-user-graph purun">
          <Key :size="150" fillColor="#FFC7AF"></Key>  %
        </div>
      </div>
    </div>
  </div>
</div>
</template>

<script>
import Account from 'vue-material-design-icons/Account.vue';
import Key from 'vue-material-design-icons/Key.vue';

import UserInfoGraph from '../components/UserInfoGraph.vue'

export default {
  data(){
    return{
      src: this.$store.state.auth.user.user.data.image,
    }
  },
  components:{
    UserInfoGraph,
    Account,
    Key,
  },
  methods:{
  },
  computed:{
    percentage(){
      if(this.doneCardsCount + this.deadlinedCardsCount!==0){
        return ((this.doneCardsCount/(this.doneCardsCount + this.deadlinedCardsCount))*100 + '%')
      }else{
        return '集計するタスクがまだありません'
      }
    },
    countedCardsCount(){
      return this.doneCardsCount + this.deadlinedCardsCount
    },
    schedulizedCardsCount() {
       return this.$store.getters['cards/schedulizedCards'].length
    },
    deadlinedCardsCount() {
      return this.$store.getters['cards/deadlinedCards'].length
    },
    doneCardsCount() {
      return this.$store.getters['cards/doneCards'].length
    }
  },
  mounted(){
    this.$store.dispatch('cards/fetchCardsAction')
  },
}
</script>

<style scoped>
.user-info-page{
/* background: #EEFFFF; */
width: 100vw;
height: 100vh;
background: #EEFFFF;
/* width: 100%;
height: 100%; */
}

.user-info{
  width: 80vw;
  margin-left:10%;
  margin-right:10%;
} 
.user-info-title{
  position: fixed;
  top: 12%;
  left: 10%;
  font-size: 40px;
} 

.user-name-item{
  position: fixed;
  top: 17%;
  left: 15%;
  font-size: 40px;
}
.user-name{
  position: fixed;
  top: 17%;
  left: 31%;
  font-size: 40px;
}
.user-email-item{
  position: fixed;
  top: 22%;
  left: 15%;
  font-size: 40px;
}
.user-email{
  position: fixed;
  top: 22%;
  left: 31%;
  font-size: 40px;
}
.user-image-item{
  position: fixed;
  top: 35%;
  left: 15%;
  font-size: 40px;
}
.user-image{
  position: fixed;
  top: 28%;
  left: 31%;
  font-size: 40px;
}
.alternative-user-image{
  position: fixed;
  top: 33%;
  left: 31%;
  font-size: 40px;

}
.guest-user-image{
  position: fixed;
  top: 33%;
  left: 31%;
  font-size: 40px;
}
.user-graph-item{
  position: fixed;
  top: 15%;
  left: 45%;
  font-size: 100px;
}
.user-graph{
  position: fixed;
  top: 15%;
  left: 70%;
  font-size: 100px;
}
.guest-user-graph{
  position: fixed;
  top: 15%;
  left: 70%;
  font-size: 100px;
}
.finished-cards-item{
  position: fixed;
  top: 25%;
  left: 50%;
  font-size: 40px;
}
.finished-cards{
  position: fixed;
  top: 25%;
  left: 70%;
  font-size: 40px;
}
.guest-finished-cards{
  position: fixed;
  top: 24%;
  left: 70%;
  font-size: 40px;
}
.deadlined-cards-item{
  position: fixed;
  top: 35%;
  left: 50%;
  font-size: 40px;
}
.deadlined-cards{
  position: fixed;
  top: 35%;
  left: 70%;
  font-size: 40px;
}
.guest-deadlined-cards{
  position: fixed;
  top: 34%;
  left: 70%;
  font-size: 40px;
}
.schedulized-cards-item{
  position: fixed;
  top:43%;
  left: 50%;
  font-size: 40px;
}
.schedulized-cards{
  position: fixed;
  top: 43%;
  left: 70%;
  font-size: 40px;
}
.guest-schedulized-cards{
  position: fixed;
  top: 42%;
  left: 70%;
  font-size: 40px;
}
.counted-cards{
  position: fixed;
  top: 30%;
  left: 80%;
  font-size: 40px;
}
.guest-counted-cards{
  position: fixed;
  top: 30%;
  left: 80%;
  font-size: 40px;
}
.graph{
  position: fixed;
  top: 48%;
  font-size: 40px;
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
