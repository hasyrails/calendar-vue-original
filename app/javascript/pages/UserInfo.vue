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
        <div class="user-graph-item">
          初志の勝率：
        </div>
        <div class="user-graph">
          %
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data(){
    return{
      src: this.$store.state.auth.user.user.data.image
    }
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
  left: 20%;
  font-size: 40px;
} 

.user-name-item{
  position: fixed;
  top: 17%;
  left: 30%;
  font-size: 40px;
}
.user-name{
  position: fixed;
  top: 17%;
  left: 43%;
  font-size: 40px;
}
.user-email-item{
  position: fixed;
  top: 22%;
  left: 30%;
  font-size: 40px;
}
.user-email{
  position: fixed;
  top: 22%;
  left: 43%;
  font-size: 40px;
}
.user-image-item{
  position: fixed;
  top: 35%;
  left: 30%;
  font-size: 40px;
}
.user-image{
  position: fixed;
  top: 28%;
  left: 43%;
  font-size: 40px;
}
.user-graph-item{
  position: fixed;
  top: 48%;
  left: 30%;
  font-size: 40px;
}
.user-graph{
  position: fixed;
  top: 48%;
  left: 43%;
  font-size: 40px;
}

</style>
