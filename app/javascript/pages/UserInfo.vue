<template>
  <div class="user-info-page">
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
        <div class="user-image">
          <img style="border-radius:50%;" :src="src" width="300" height="300">
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
        <div class="user-graph">
          {{percentage}} %
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data(){
    return{
      src: this.$store.state.auth.user.user.data.image,
    }
  },
  computed:{
    percentage(){
      return (this.doneCardsCount/(this.doneCardsCount + this.deadlinedCardsCount))*100
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
.user-graph-item{
  position: fixed;
  top: 17%;
  left: 50%;
  font-size: 100px;
}
.user-graph{
  position: fixed;
  top: 17%;
  left: 80%;
  font-size: 100px;
}
.finished-cards-item{
  position: fixed;
  top: 30%;
  left: 50%;
  font-size: 40px;
}
.finished-cards{
  position: fixed;
  top: 30%;
  left: 70%;
  font-size: 40px;
}
.deadlined-cards-item{
  position: fixed;
  top: 40%;
  left: 50%;
  font-size: 40px;
}
.deadlined-cards{
  position: fixed;
  top: 40%;
  left: 70%;
  font-size: 40px;
}
.schedulized-cards-item{
  position: fixed;
  top:60%;
  left: 50%;
  font-size: 40px;
}
.schedulized-cards{
  position: fixed;
  top: 60%;
  left: 70%;
  font-size: 40px;
}
.counted-cards{
  position: fixed;
  top: 35%;
  left: 80%;
  font-size: 40px;
}
</style>
