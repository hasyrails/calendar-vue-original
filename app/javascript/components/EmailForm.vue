<template>
  <div class="form-container">
  <form @input="submit" class="register-form">
    <h2>メールアドレスを入力してください</h2>
    <div class="form-group">
      <label for="Email">メールアドレス</label>
      <input type="text" class="form-control form-control-lg" v-model="email" placeholder="Enter Email">
    </div>
  </form>
  </div>
</template>

<script>
export default {
  name: 'EmailForm',
  data(){
    return{
      email: null
    }
  },
  methods: {
		submit(){
			this.$emit('update',{
				email: this.email,
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
