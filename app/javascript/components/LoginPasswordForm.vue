<template>
  <div class="form-container">
  <form @input="submit" class="register-form">
    <h2>パスワードを入力してください</h2>
    <div class="form-group">
      <label for="password">パスワード</label>
      <input type="text" class="form-control form-control-lg" v-model="password" placeholder="Enter Password">
    </div>
  </form>
  </div>
</template>
