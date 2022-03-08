# SRS predictive maintenance environments
Docker images should be as small as possible for each environment. We must consider 3 environments.

| Environment | Description |
| -- | -- |
| Explore | Data science libraries for data analysis, model development and SRD access. |
| Automate | Make available the minimum amount of libraries necessary to execute and manage the selected models, and access SRD. In this example, we're assuming the final models would use algorithms from the scikit-learn library, but other libraries could be necessary. |
| Scoring/serving | Libraries to access SRD, create webserver and serve resources to webapp (`flask`), optimize server for production (`gunicorn`), add security and load balance if necessary (`nginx`). |

In this project, ML models are executed weekly in batch.
They don't use data submitted by the user on-demand.
This means, we don't need to execute ML models in the scoring/serving environment.
We just need to serve the results produced by those models in the automate environment (and written in the SRD).

For these environments, it is assumed that the SRD can be accessed as a standard SQL database, using the `psycopg` library.

[Video explanation](https://youtu.be/SLAtHEBMbQc)

https://youtu.be/SLAtHEBMbQc

## Build images
To make sure we keep the environments versioned, we're using environment variables to write the correct version.
For each new version, we're also updating the `latest` images.

```bash
docker build -f explore.Dockerfile -t iait_explore:$EXPLORE_VERSION .
docker build -f automate.Dockerfile -t iait_automate:$AUTOMATE_VERSION .
docker build -f serving.Dockerfile -t iait_serving:$SERVING_VERSION .

docker build -f explore.Dockerfile -t iait_explore:latest .
docker build -f automate.Dockerfile -t iait_automate:latest .
docker build -f serving.Dockerfile -t iait_serving:latest .
```


To set the version environment variables (e.g. to version 0.1.0), in a Bash terminal:
```
export EXPLORE_VERSION=0.1.0
export AUTOMATE_VERSION=0.1.0
export SERVING_VERSION=0.1.0
```
