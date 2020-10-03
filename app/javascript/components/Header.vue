<template>
  <div class="header">
      <div class="app-header-contents">
        <router-link to="/">
          <div class="app-header-title">Header</div>
        </router-link>
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
  export default {
    name: 'Header',
  }
</script>

<style scoped>
.app-header-contents{
  display:flex;
}

.app-header-title{
  margin-left:10px;
  margin-right:10px;
  font-size: 75px;
  font-weight: 30px;
  color: black;
}
.app-header-link{
  display:flex;
  margin-left:70%;
  margin-right:10px;
  margin-top:30px;
  float: right;
  font-size: 30px;
  font-weight: 30px;
}

.app-header-link-register{
  margin-left:50px;
  margin-right:50px;
  color: black;
}
.app-header-link-login{
  margin-left:50px;
  margin-right:50px;
  color: black;
}
</style>
