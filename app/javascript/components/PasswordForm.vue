<template>
  <form @input="submit">
    <h2>Password Info</h2>
    <div class="form-group">
      <label for="Password">Password</label>
      <input type="password" class="form-control" v-model="password" placeholder="Enter password">
      <label for="Password">Password Confirmation</label>
      <input type="password" class="form-control" v-model="passwordConfirmation" placeholder="Enter password confirmation">
    </div>					
  </form>
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

</style>
