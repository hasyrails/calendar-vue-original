<template>
  <div class="form-container">
  <form @input="submit" class="register-form">
    <h2>パスワードを入力してください</h2>
    <div class="form-group">
      <label for="password">パスワード</label>
      <ValidationProvider name="password" rules="required|password">
        <div slot-scope="{ errors }">
        <input type="password" class="form-control form-control-lg" v-model="password" placeholder="Enter Password">
          <p class="error-message">{{ errors[0] }}</p>
        </div>
      </ValidationProvider>
    </div>
    <div class="form-group">
      <label for="userName">パスワード(確認)</label>
      <ValidationProvider name="password_confirmation" rules="required|confirmed:password">
        <div slot-scope="{ errors }">
        <input type="password" class="form-control form-control-lg" v-model="password_confirmation" placeholder="Enter Password">
          <p class="error-message">{{ errors[0] }}</p>
        </div>
      </ValidationProvider>
    </div>
  </form>
  </div>
</template>

<script>
import Eye from 'vue-material-design-icons/Eye.vue';
import { ValidationProvider } from 'vee-validate';

export default {
  name: 'PasswordForm',
  data(){
    return{
      password: null,
      password_confirmation: null
    }
  },
  components:{
    Eye,
    ValidationProvider
  },
  methods: {
		submit(){
			this.$emit('update',{
				password: this.password,
				password_confirmation: this.password_confirmation
			});
    },
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

  .error-message{
    color: red;
    font-size:20px;
  }
</style>
