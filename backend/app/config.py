from pydantic import BaseSettings

class Settings(BaseSettings):
    environment: str = 'development'
    ai_provider: str = 'gemini'
    secret_key: str = 'please-change'

    class Config:
        env_file = '.env'

settings = Settings()
