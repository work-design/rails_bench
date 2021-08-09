import { createApp } from 'vue'
import App from 'rails_bench_engine_vue/index'

const app = createApp(App)
app.config.performance = true
app.mount('#app')
