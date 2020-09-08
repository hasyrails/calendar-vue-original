<template>
  <div>
    <h2>Confirmation</h2>
		<p>Name: {{ form.userName }} {{ form.lastName }}</p>
		<p>Email: {{ form.email }}</p>
		<p>Password: {{ form.password }}</p>
		<p>Password Confirmation: {{ form.passwordConfirmation }}</p>
  </div>
</template>

<script>
export default {
  name: 'ConfirmForm',
  props:{
		form: Object
	}
}
</script>

<style scoped>

</style>
