<template>
  <div class="app-header">
    <div class="app-header-contents">
      <router-link to="/">
        <div class="app-header-title">初志しか勝たん<BoxingGlove :size="70"></BoxingGlove></div>
        <!-- <p class="app-header-title-footer">初志貫徹アプリ</p> -->
      </router-link>
      <div>{{ this.$store.state.auth.headers }}</div>
      <div class="app-header-link">
        <router-link to="/register">
          <div class="app-header-link-register">ユーザー登録</div>
        </router-link>
        <router-link to="/login">
          <div class="app-header-link-login">ログイン</div>
        </router-link>
      </div>
    </div>
  </div>
</template>

<script>
import {mapState} from 'vuex'
import BoxingGlove from 'vue-material-design-icons/BoxingGlove.vue';

  export default {
    name: 'Header',
    data(){
      return{
        users:{}
      }
    },
    components:{
      BoxingGlove,
    },
  }

</script>

<style scoped>
.app-header{
  background: #AFEEEE;
  height: 150px;
  color: black;
  font-style: italic;
  /* text-align: left; */
  /* padding: 20px; */
  position:absolute;
  top: 0px;
  width:100vw;
  position: fixed;
  /* z-index: 2; */
}

.app-header-contents{
  display:flex;
}

.app-header-title{
  margin-top:20px;
  margin-left:20%;
  margin-right:10px;
  font-size: 60px;
  font-weight: 30px;
  font-family: "Hiragino Sans","ヒラギノ角ゴシック"; font-weight: 900;
  color: black;
  width:500px;
}
.app-header-title-footer{
  margin-left:20%;
  margin-right:10px;
  font-size: 20px;
  font-weight: 30px;
  font-family: "Hiragino Sans","ヒラギノ角ゴシック"; font-weight: 900;
  color: black;
  width:500px;
}
.app-header-link{
  display:flex;
  margin-left:60%;
  margin-right:10px;
  margin-top:40px;
  float: right;
  font-size: 40px;
  font-weight: 30px;
  /* justify-content: space-between; */
}

.app-header-link-register{
  /* margin-left:10px; */
  /* margin-right:100px; */
  color: black;
  width:300px;
}
.app-header-link-login{
  /* margin-left:10px; */
  /* margin-right:10px; */
  color: black;
  width:300px;
}
</style>
