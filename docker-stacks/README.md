# docker-stacks

Stacks van kant-en-klare Jupyter applicaties in Docker.
Afgeleid van https://github.com/jupyter/docker-stacks

## Quick Start

Als je bekend bent met Docker, en het op jouw systeem al is geïnstalleerd, dan zou dit 
in de meeste gevallen moeten werken:
```
docker run -d -P nijmegenr/<your desired stack>
```

## Aan de slag

Als je Docker voor het eerst gaat gebruiken, dan moet je de volgende stappen uitvoeren:

1. [Installeer Docker](https://docs.docker.com/installation/) op jouw computer
2. Open het README bestand in een van de folders in deze git repository.
3. Volg de hierin vermelde instructies voor deze stack.

## Visueel overzicht

Dit is een diagram van de `FROM` relaties tussen de images die in dit project en jupyter/data-stack
gedefinieerd zijn.

[![Afbeelding overerving diagram](internal/inherit-diagram.png)](http://interactive.blockdiag.com/?compression=deflate&src=eJyFzbEOgkAMgOGdp7iwsxsJRjZ3R2NMjyumcrTkrsag8d3l3I6F9e_X1nrpBkdwN5_CGAmErKAkbBozSdAApPUycdjD0-utF9ZIb1zGu9Rbc_Fg0TelQ0vA-wfGSHg8n9ryWhd_UR2MhYgVi6IVGdJeFpIYiWkEn6F1Sy52NM2Zyksyihwl9F5eG9CBwlKRO9x8HDZuTXOcIAyZWrfkwPtqLb8_jh2GrQ)

## Stacks, Tags, Versies en Voortgang

Te beginnen bij [git commit SHA 9bd33dcc8688](https://github.com/jupyter/docker-stacks/tree/9bd33dcc8688):

* Bijna elke folder hier op GitHub heeft een overeenkomstige `nijmegenr/<stack name>` op Docker Hub
(bijv., data-science-geo &rarr; nijmegenr/data-science-geo).
* De `latest` tag in elke Docker Hub repository verwijst naar de `master` tak `HEAD` op GitHub.
* Elke 12-teken tag op Docker Hub verwijst naar een git commit SHA hier op GitHub.

## Andere tips en bekende issues

* `tini -- start-notebook.sh` is de standaard Docker ingang in elke notebook stack.
  Mocht je dat willen wijzigen, kijk dan voor de consequenties in elk geval in *Notebook Opties* sectie
  van het README bestand.
* Elke notebook stack is compatibel met [JupyterHub](https://jupyterhub.readthedocs.io) 0.5.
  Als je het gebruikt met JupyterHub, dan moet je het Docker run commando laten wijzen naar
  het [start-singleuser.sh](base-notebook/start-singleuser.sh) script,
  dat een single-user instantie van de Notebook server start.
  Zie het README bestand van elke stack voor instructies over het gebruik op JupyterHub.
* Check de [Docker recipes wiki pagina](https://github.com/jupyter/docker-stacks/wiki/Docker-Recipes)
  die hoort bij het docker-stacks project voor informatie over het uitbreiden en gebruiken van
  de Docker images.
* Al de stacks die afgeleid zijn van minimal-notebook hebben het conda jpeg package vastgezet op
  versie 8 totdat https://github.com/jupyter/docker-stacks/issues/210 is opgelost.
