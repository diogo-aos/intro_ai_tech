Docker images should be as small as possible for each environment. We must consider 3 environments:
- exploration: data science libraries that might be relevant for  data analysis, model development and SRD access.
- automate: make available the minimum amount of libraries necessary to execute and manage the selected models, and access SRD.
- scoring/serving: libraries to access SRD and serve webapp.

In this project, ML models are executed weekly in batch.
They don't use data submitted by the user on-demand.
This means, we don't need to execute ML models in the scoring/serving environment.
We just need to serve the results produced by those models in the automate environment (and written in the SRD).

# Build images
docker build -f explore.Dockerfile -t iait_explore
docker build -f explore.Dockerfile -t iait_automate
docker build -f explore.Dockerfile -t iait_serving