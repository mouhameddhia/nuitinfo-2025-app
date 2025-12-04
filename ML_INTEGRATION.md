# Machine Learning Integration Examples

This file provides examples for integrating ML/Data Science features into your Nuit de l'Info application.

## Quick Integration

Since you're data scientists, here are ready-to-use patterns for common ML tasks.

## 1. Simple Prediction Endpoint

### Backend Setup

**Install ML dependencies:**
```powershell
cd backend
.\venv\Scripts\Activate.ps1
pip install scikit-learn pandas numpy
pip freeze > requirements.txt
```

**Create ML service:**
```python
# backend/app/services/ml_service.py
import pandas as pd
import numpy as np
from sklearn.ensemble import RandomForestClassifier
import joblib
from pathlib import Path

class MLService:
    def __init__(self):
        self.model = None
        self.model_path = Path("models/model.joblib")
        
    def train_model(self, X_train, y_train):
        """Train a simple model"""
        self.model = RandomForestClassifier(n_estimators=100)
        self.model.fit(X_train, y_train)
        
        # Save model
        self.model_path.parent.mkdir(exist_ok=True)
        joblib.dump(self.model, self.model_path)
        
    def load_model(self):
        """Load trained model"""
        if self.model_path.exists():
            self.model = joblib.load(self.model_path)
            return True
        return False
        
    def predict(self, features: list):
        """Make prediction"""
        if self.model is None:
            self.load_model()
            
        if self.model is None:
            raise ValueError("Model not trained")
            
        X = np.array(features).reshape(1, -1)
        prediction = self.model.predict(X)
        probabilities = self.model.predict_proba(X)
        
        return {
            "prediction": int(prediction[0]),
            "probabilities": probabilities[0].tolist(),
            "confidence": float(max(probabilities[0]))
        }

# Global instance
ml_service = MLService()
```

**Create ML endpoints:**
```python
# backend/app/api/v1/ml.py
from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
from app.services.ml_service import ml_service

router = APIRouter()

class PredictionRequest(BaseModel):
    features: list[float]

class PredictionResponse(BaseModel):
    prediction: int
    probabilities: list[float]
    confidence: float

@router.post("/predict", response_model=PredictionResponse)
async def predict(request: PredictionRequest):
    """Make prediction from features"""
    try:
        result = ml_service.predict(request.features)
        return result
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))

@router.get("/model/status")
async def model_status():
    """Check if model is loaded"""
    is_loaded = ml_service.load_model()
    return {
        "loaded": is_loaded,
        "model_path": str(ml_service.model_path)
    }
```

**Add to main.py:**
```python
# backend/app/main.py
from app.api.v1 import ml

app.include_router(ml.router, prefix="/api/v1/ml", tags=["Machine Learning"])
```

### Frontend Integration

```typescript
// frontend/src/services/mlService.ts
import api from './api'

interface PredictionRequest {
  features: number[]
}

interface PredictionResponse {
  prediction: number
  probabilities: number[]
  confidence: number
}

export const mlService = {
  async predict(features: number[]): Promise<PredictionResponse> {
    const response = await api.post<PredictionResponse>('/ml/predict', {
      features
    })
    return response.data
  },

  async getModelStatus() {
    const response = await api.get('/ml/model/status')
    return response.data
  }
}
```

```typescript
// frontend/src/pages/MLDemo.tsx
import { useState } from 'react'
import { mlService } from '@/services/mlService'

function MLDemo() {
  const [features, setFeatures] = useState<string>('1.5,2.3,3.1,4.2')
  const [result, setResult] = useState<any>(null)
  const [loading, setLoading] = useState(false)

  const handlePredict = async () => {
    setLoading(true)
    try {
      const featureArray = features.split(',').map(Number)
      const prediction = await mlService.predict(featureArray)
      setResult(prediction)
    } catch (error) {
      console.error('Prediction failed:', error)
    } finally {
      setLoading(false)
    }
  }

  return (
    <div style={{ padding: '2rem' }}>
      <h1>ML Prediction Demo</h1>
      
      <div style={{ marginTop: '2rem' }}>
        <label>Features (comma-separated):</label>
        <input
          type="text"
          value={features}
          onChange={(e) => setFeatures(e.target.value)}
          style={{ width: '100%', padding: '0.5rem', marginTop: '0.5rem' }}
        />
      </div>
      
      <button 
        onClick={handlePredict}
        disabled={loading}
        style={{ marginTop: '1rem', padding: '0.75rem 2rem' }}
      >
        {loading ? 'Predicting...' : 'Predict'}
      </button>
      
      {result && (
        <div style={{ marginTop: '2rem', padding: '1rem', background: '#f5f5f5' }}>
          <h3>Result:</h3>
          <p><strong>Prediction:</strong> {result.prediction}</p>
          <p><strong>Confidence:</strong> {(result.confidence * 100).toFixed(2)}%</p>
          <p><strong>Probabilities:</strong> {result.probabilities.map((p: number) => 
            (p * 100).toFixed(2) + '%'
          ).join(', ')}</p>
        </div>
      )}
    </div>
  )
}

export default MLDemo
```

## 2. Data Processing Endpoint

```python
# backend/app/api/v1/data.py
from fastapi import APIRouter, UploadFile, File
import pandas as pd
import io

router = APIRouter()

@router.post("/process-csv")
async def process_csv(file: UploadFile = File(...)):
    """Process uploaded CSV file"""
    contents = await file.read()
    df = pd.read_csv(io.BytesIO(contents))
    
    # Example processing
    summary = {
        "rows": len(df),
        "columns": list(df.columns),
        "dtypes": df.dtypes.astype(str).to_dict(),
        "missing": df.isnull().sum().to_dict(),
        "statistics": df.describe().to_dict()
    }
    
    return summary

@router.post("/analyze")
async def analyze_data(data: dict):
    """Analyze data and return insights"""
    df = pd.DataFrame(data)
    
    analysis = {
        "shape": df.shape,
        "memory_usage": df.memory_usage(deep=True).sum(),
        "numeric_columns": df.select_dtypes(include=['number']).columns.tolist(),
        "categorical_columns": df.select_dtypes(include=['object']).columns.tolist(),
        "correlations": df.corr().to_dict() if not df.select_dtypes(include=['number']).empty else {}
    }
    
    return analysis
```

## 3. Real-time Data Visualization

### Backend: Streaming endpoint

```python
# backend/app/api/v1/stream.py
from fastapi import APIRouter
from fastapi.responses import StreamingResponse
import asyncio
import json
import numpy as np

router = APIRouter()

async def generate_data():
    """Generate streaming data"""
    while True:
        data = {
            "timestamp": pd.Timestamp.now().isoformat(),
            "value": float(np.random.randn()),
            "metric": float(np.random.uniform(0, 100))
        }
        yield f"data: {json.dumps(data)}\n\n"
        await asyncio.sleep(1)

@router.get("/live-data")
async def live_data():
    """Stream live data"""
    return StreamingResponse(
        generate_data(),
        media_type="text/event-stream"
    )
```

### Frontend: Real-time chart

```typescript
// frontend/src/components/LiveChart.tsx
import { useEffect, useState } from 'react'

interface DataPoint {
  timestamp: string
  value: number
  metric: number
}

function LiveChart() {
  const [data, setData] = useState<DataPoint[]>([])

  useEffect(() => {
    const eventSource = new EventSource('http://localhost:8000/api/v1/stream/live-data')
    
    eventSource.onmessage = (event) => {
      const newPoint = JSON.parse(event.data)
      setData((prev) => [...prev.slice(-50), newPoint]) // Keep last 50 points
    }
    
    return () => eventSource.close()
  }, [])

  return (
    <div>
      <h2>Live Data Stream</h2>
      <div style={{ height: '300px', background: '#f5f5f5', padding: '1rem' }}>
        {data.map((point, i) => (
          <div key={i} style={{ fontSize: '0.8rem' }}>
            {new Date(point.timestamp).toLocaleTimeString()}: 
            Value={point.value.toFixed(2)}, 
            Metric={point.metric.toFixed(2)}
          </div>
        ))}
      </div>
    </div>
  )
}

export default LiveChart
```

## 4. Database Storage for ML Results

```python
# backend/app/models/models.py
class Prediction(SQLModel, table=True):
    __tablename__ = "predictions"
    
    id: Optional[int] = Field(default=None, primary_key=True)
    user_id: int = Field(foreign_key="users.id")
    features: str  # JSON string
    prediction: int
    confidence: float
    model_version: str = "v1.0"
    created_at: datetime = Field(default_factory=datetime.utcnow)
```

```python
# backend/app/api/v1/ml.py (updated)
from app.models.models import Prediction
from sqlmodel import Session
from app.database import get_session
import json

@router.post("/predict")
async def predict(
    request: PredictionRequest,
    session: Session = Depends(get_session),
    current_user: User = Depends(get_current_active_user)
):
    result = ml_service.predict(request.features)
    
    # Save prediction
    prediction = Prediction(
        user_id=current_user.id,
        features=json.dumps(request.features),
        prediction=result["prediction"],
        confidence=result["confidence"]
    )
    session.add(prediction)
    session.commit()
    
    return result

@router.get("/predictions/history")
async def get_prediction_history(
    session: Session = Depends(get_session),
    current_user: User = Depends(get_current_active_user)
):
    """Get user's prediction history"""
    statement = select(Prediction).where(
        Prediction.user_id == current_user.id
    ).order_by(Prediction.created_at.desc()).limit(50)
    
    predictions = session.exec(statement).all()
    return predictions
```

## 5. External API Integration (e.g., OpenAI)

```python
# backend/app/services/ai_service.py
import openai
from app.config import settings

class AIService:
    def __init__(self):
        openai.api_key = settings.OPENAI_API_KEY
        
    async def analyze_text(self, text: str) -> dict:
        """Analyze text using GPT"""
        response = openai.ChatCompletion.create(
            model="gpt-3.5-turbo",
            messages=[
                {"role": "system", "content": "You are a helpful data analyst."},
                {"role": "user", "content": f"Analyze this text: {text}"}
            ]
        )
        return {
            "analysis": response.choices[0].message.content,
            "model": response.model,
            "tokens": response.usage.total_tokens
        }

ai_service = AIService()
```

## Quick Tips

1. **Keep models separate:** Store in `backend/models/` directory
2. **Use caching:** Cache predictions for common inputs
3. **Async processing:** Use background tasks for heavy ML operations
4. **Model versioning:** Track model versions in database
5. **Error handling:** Wrap predictions in try-catch
6. **Monitoring:** Log prediction latency and accuracy

## Example: Full ML Feature (Competition Use Case)

Let's say the competition asks for "Environmental Impact Prediction":

```python
# backend/app/services/environment_ml.py
class EnvironmentMLService:
    def predict_carbon_footprint(self, transport: str, distance: float, 
                                 passengers: int) -> dict:
        # Simplified example
        carbon_per_km = {
            "car": 0.2,
            "bus": 0.05,
            "train": 0.03,
            "plane": 0.25
        }
        
        base_emission = carbon_per_km.get(transport, 0.15) * distance
        per_person = base_emission / max(passengers, 1)
        
        return {
            "total_emission_kg": base_emission,
            "per_person_kg": per_person,
            "transport": transport,
            "recommendation": "Consider train for lower emissions" if per_person > 5 else "Good choice!"
        }
```

## Resources

- **FastAPI**: https://fastapi.tiangolo.com
- **Scikit-learn**: https://scikit-learn.org
- **Pandas**: https://pandas.pydata.org
- **Chart.js** (for frontend): https://www.chartjs.org

## During Competition

1. Identify ML requirements from subject
2. Start with simple model (don't overcomplicate)
3. Use pre-trained models if available (HuggingFace)
4. Focus on integration, not perfect accuracy
5. Add visualization for impact
6. Document your approach in README

Good luck! 🚀
