from fastapi import FastAPI
from .api.health import router as health_router

app = FastAPI(title='Meow AI Backend')

app.include_router(health_router, prefix='/api')

@app.get('/')
def root():
    return {'status': 'ok', 'message': 'Meow AI backend'}
