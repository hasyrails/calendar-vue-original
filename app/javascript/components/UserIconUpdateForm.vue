<template>
<div>
  <p id="error" v-show="error" style="color:red;">{{ error }}</p>
  <label>
    <div v-if="image">
      <img :src="image" 
      width="100" height="100"
      alt="Avatar" class="image" style="border-radius:50%;">
    </div>
    <div class="form-group">
    <input
           type="file"
           id="avatar_name"
           accept="image/jpeg, image/png"
           class="form-control-file" 
           @change="onImageChange"
           style="margin-right:10%;"
           />
    </div>
  </label>
  <div style="margin-left:15%; font-size:10px;">
    <button class="btn btn-sm btn-info" @click="updateUserIcon()">アップロード</button>
  </div>
  <p style="color:blue;">{{ message }}</p>
</div>
</template>

<script>
export default{
    name: 'UserIconForm',
    data () {
      return {
        image: '',
        message: '',
        error: ''
      }
    },
    methods: {
      setError (error, text) {
        this.error = (error.response && error.response.data && error.response.data.error) || text
      },
      getBase64 (file) {
        return new Promise((resolve, reject) => {
          const reader = new FileReader()
          reader.readAsDataURL(file)
          reader.onload = () => resolve(reader.result)
          reader.onerror = error => reject(error)
        })
      },
      onImageChange (e) {
        this.$store.state.srcFlag = false
        const images = e.target.files || e.dataTransfer.files
        this.getBase64(images[0])
          .then(image => this.image = image)
          .catch(error => this.setError(error, '画像のアップロードに失敗しました。'))
      },
      updateUserIcon() {
          if (this.image) {
            this.$store.dispatch('auth/updateUserIconAction',{"image": this.image})
          this.message = 'ユーザーアイコンを更新しました' 
          this.error = ''
        } else {
          this.error = '画像がありません'
        }
      }
    }
} 
</script>
