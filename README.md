# CoastalPulse

_The CoastalPulse project, which analyzes tourism trends, was created for the Bank of Greece Datathon. The marketing director of a tourism board, Jane, wants to understand the current trends and predict upcoming drops in the tourism sector. CoastalPulse, a patent-pending technology that provides real-time analysis of images and videos from various sources, including satellite and surveillance cameras, was learned about by her. CoastalPulse can integrate with Google Maps and uses advanced models to predict market trends in the tourism industry. By leveraging real-time image analysis and predictive capabilities, marketing is facilitated targeting potential visitors during anticipated downturns in the tourism sector. The coastal destination benefits from more evenly distributed tourists, reduced overcrowding at popular attractions, and a more stable tourism industry. Valuable insights and data-driven predictions are provided to inform marketing decisions and ensure the long-term success of the coastal destination._

![image](https://user-images.githubusercontent.com/88648326/233836219-db118e65-e5e1-4599-b57b-86e91a1d7a7b.png)

![image](https://user-images.githubusercontent.com/88648326/233836306-53040a40-7f8b-495c-89e4-a2b37be814c0.png)

![image](https://user-images.githubusercontent.com/88648326/233836315-c42bfc5c-3705-4e9b-9cb9-ea5b4a266cea.png)


<a name="readme-top"></a>

<details>
  <summary>Table of Contents</summary>
  <ol>
    <li><a href="#use">Use cases</a></li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#Installation">Installation</a></li>
    <li><a href="#team">Team</a></li>
  </ol>
</details>

## Use case


### Optimizing Tourism Marketing Campaigns with CoastalPulse

#### Objective
Jane, the marketing director of a tourism board, wants to understand the current trends and predict upcoming drops in the tourism sector to optimize marketing campaigns for her coastal destination. CoastalPulse, a patent-pending technology, can provide her with valuable insights and data-driven predictions to ensure long-term success and stability in the tourism industry.

#### Data Collection and Integration
Jane's team integrates CoastalPulse with Google Maps and configures it to collect real-time images and videos from various sources, such as satellite and surveillance cameras, covering the coastal destination and its popular attractions.

#### Model Training and Deployment
Using Python and the PyTorch framework, Jane's team trains machine learning models to analyze the collected images and videos for various patterns and trends. These models are deployed on a FastAPI backend, providing a scalable and efficient solution for real-time analysis.

#### Predictive Analytics
CoastalPulse uses the trained models to identify trends in visitor patterns and predict potential downturns in the tourism sector. These predictions are generated based on factors such as historical data, seasonal patterns, and current events that may impact tourism.

#### Marketing Strategy Development
Jane and her team use the insights and predictions provided by CoastalPulse to develop targeted marketing campaigns aimed at potential visitors during anticipated downturns. By promoting the coastal destination during these periods, they can help distribute tourists more evenly throughout the year, reducing overcrowding at popular attractions and ensuring a more stable tourism industry.

#### Performance Evaluation and Improvement
Jane's team continuously monitors the performance of their marketing campaigns and the accuracy of CoastalPulse's predictions. They use this feedback to refine their marketing strategies and improve the machine learning models, ensuring they remain up to date and effective.

#### Outcome
By leveraging CoastalPulse's real-time image analysis and predictive capabilities, Jane's coastal destination benefits from optimized marketing campaigns, more evenly distributed tourists, reduced overcrowding at popular attractions, and a more stable tourism industry. This innovative solution enables data-driven decision-making, ensuring the long-term success of the coastal destination.

### Tasks for Implementing

* Data collection and integration. Identify and access relevant data sources for images and videos (satellite, surveillance cameras, etc.)
* Model training and deployment. Select appropriate machine learning algorithms for trend analysis and prediction
* Predictive analytics. Generate insights and predictions based on the trained models and real-time data analysis
* Analyze the effectiveness of marketing campaigns and the accuracy of CoastalPulse predictions
* Develop cross-platform for native application for iOS and react for web

<p align="right">(<a href="#readme-top">back to top</a>)</p>


## Usage

Start back-end.

### Activate python virtual environment

```bash
# create venv
python -m venv .dev
# activate env
source .dev/bin/activate
pip install -r requirements.txt
```

### Deploy server

```bash
uvicorn main:app --reload
```

Docs (swagger)  ``http://127.0.0.1:8000/docs``.

Export dependencies:

```bash
pip3 freeze > requirements.txt
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Installation

### Start fornt end

```bash
cd coastalpulse
npm install leaflet react-leaflet
npm start
```

### Dataset

* https://opendata.bankofgreece.gr/
  * https://opendata.bankofgreece.gr/el/dataset/35
  * https://opendata.bankofgreece.gr/el/dataset/26
  * https://opendata.bankofgreece.gr/el/dataset/27
  * https://opendata.bankofgreece.gr/el/dataset/28
  * https://opendata.bankofgreece.gr/el/dataset/41
  * https://opendata.bankofgreece.gr/el/dataset/29
  * https://opendata.bankofgreece.gr/el/dataset/43
  * https://opendata.bankofgreece.gr/el/dataset/30
  * https://opendata.bankofgreece.gr/el/dataset/42
  * https://opendata.bankofgreece.gr/el/dataset/23
* Travellers by age, according to destination and length of trip
  * https://ine.es/dyngs/INEbase/en/operacion.htm?c=Estadistica_C&cid=1254736176990&menu=ultiDatos&idp=1254735576863

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Team

* Nikitas Gerolimos
* Ilias Georgousis
* Dimitra Maliarou
* Georgios (Giorgos) Hobis
* Matthaios Tasios
* Alexis Stathopoulos
* Adonis Messinis
* Vasileios (Vasilis) Alevizos

<p align="right">(<a href="#readme-top">back to top</a>)</p>
