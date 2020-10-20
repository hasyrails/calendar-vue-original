<template>
  <div class="form-container">
  <form @input="submit" class="register-form">
    <h2>ユーザー名を入力してください</h2>
    <div class="form-group">
      <label for="userName">ユーザー名</label>
      <input type="text" class="form-control form-control-lg" v-model="name" placeholder="Enter User Name">
    </div>
  </form>
  </div>
</template>

<script>
export default {
  name: 'UserNameForm',
  data(){
    return{
      name: null
    }
  },
  methods: {
    submit(){
			this.$emit('update',{
				name: this.name
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
