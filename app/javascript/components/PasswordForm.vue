<template>
  <div class="form-container">
  <form @input="submit" class="register-form">
    <h2>パスワードを入力してください</h2>
    <div class="form-group">
      <label for="password">パスワード</label>
      <input type="text" class="form-control form-control-lg" v-model="password" placeholder="Enter Password">
    </div>
    <div class="form-group">
      <label for="userName">パスワード(確認)</label>
      <input type="text" class="form-control form-control-lg" v-model="passwordConfirmation" placeholder="Enter Password Confirmation">
    </div>
  </form>
  </div>
</template>

<script>
export default {
  name: 'PasswordForm',
  data(){
    return{
      password: null,
      passwordConfirmation: null
    }
  },
  methods: {
		submit(){
			this.$emit('update',{
				password: this.passwordConfirmation,
				passwordConfirmation: this.passwordConfirmation
			});
		}
	}
}
</script>

<style scoped>
 .form-container{
    /* width: 100%; */
    margin-left:3%;
    margin-right:3%;
    margin-top:3%;
  }

  .register-form{
    text-align: left;
  }

  .form-control{
    width: 50%;
  }
</style>
