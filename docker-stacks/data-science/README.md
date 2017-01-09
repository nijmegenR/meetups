# Jupyter Notebook Data Science Stack

## Wat zit erin?

* Jupyter Notebook 4.3.x
* Conda Python 3.x en Python 2.7.x omgevingen
* pandas, matplotlib, scipy, seaborn, scikit-learn, scikit-image, sympy,
  cython, patsy, statsmodel, cloudpickle, dill, numba, bokeh en feather voorgeïnstalleerd
* Conda R v3.3.x en channel
* plyr, devtools, dplyr, ggplot2, tidyr, shiny, rmarkdown, forecast, stringr, rsqlite,
  reshape2, nycflights13, caret, rcurl, randomforest en feather voorgeïnstalleerd
* Gebruiker `jovyan` zonder privileges (uid=1000, configureerbaar, zie opties) in de groep `users`
  (gid=100), eigenaar van `/home/jovyan` en `/opt/conda`
* [tini](https://github.com/krallin/tini) is de container ingang en
  [start-notebook.sh](https://github.com/jupyter/docker-stacks/blob/master/base-notebook/start-notebook.sh)
  is het standaard commando
* Een [start-singleuser.sh](https://github.com/jupyter/docker-stacks/blob/master/base-notebook/start-singleuser.sh)
  script dat handig is voor het draaien van een single-user instantie van de Notebook server,
  zoals door JupyterHub wordt vereist
* Een [start.sh](https://github.com/jupyter/docker-stacks/blob/master/base-notebook/start.sh)
  script voor het draaien van alternatieve commando's in de container (bijv. `ipython`,
  `jupyter kernelgateway`, `jupyter lab`)
* Opties voor een self-signed HTTPS certificate en `sudo` zonder wachtwoord

## Basis gebruik

Het volgende commando start een container met een Notebook server die luistert op poort 8888
voor HTTP connecties met een random gegenereerd authenticatie token.

```
docker run -it --rm -p 8888:8888 nijmegen/data-science
```

Onthoud het authenticatie token dat wordt getoond bij het opstarten van de notebook.
Geef het op in de URL die je gebruikt om contact te maken met de Notebook server of gebruik het
als wachtwoord in het login scherm.

## Notebook Opties

De Docker container voor standaar het
[`start-notebook.sh` script](https://github.com/jupyter/docker-stacks/blob/master/base-notebook/start-notebook.sh)
script uit.
Het `start-notebook.sh` script voert de `NB_UID` and `GRANT_SUDO` features uit zoals beschreven
in de volgende sectie, en daarna het the `jupyter notebook`.

Je kunt [Jupyter commando opties](https://jupyter.readthedocs.io/en/latest/projects/jupyter-command.html)
doorgeven aan het `start-notebook.sh` script bij het opstarten van de container.
Bijvoorbeeld, om de Notebook server te beveiligen met een aangepast wachtwoord
versleuteld met `IPython.lib.passwd()` in plaats van het standaard token, doe het volgende:

```
docker run -d -p 8888:8888 nijmegen/data-science start-notebook.sh --NotebookApp.password='sha1:74ba40f8a388:c913541b7ee99d15d5ed31d4226bf7838f83a50e'
```

Bijvoorbeeld, om de basis URL van de Notebook server te zetten, doe het volgende:

```
docker run -d -p 8888:8888 nijmgenr/data-science start-notebook.sh --NotebookApp.base_url=/some/path
```

Bijvoorbeeld, om alle authenticatie mechanismen uit te schakelen (niet aanbevolen):

```
docker run -d -p 8888:8888 nijmegen/data-science start-notebook.sh --NotebookApp.token=''
```

Naast het `start-notebook.sh` script kun je ook je eigen commando's in de container uitvoeren.
Voor meer informatie de sectie *Alternatieve Commando's* verderop in dit document.

## Docker Opties

Je kunt het uitvoeren van de Docker container aanpassen met de volgende parameters.

* `-e GEN_CERT=yes` - Maakt een self-signed SSL certificaat en configureert Jupyter Notebook om
  het te gebruiken voor versleutelde HTTPS verbindingen.
* `-e NB_UID=1000` - Specificeer het uid van de gebruiker `jovyan`.
  Vooral nuttig om host volumes met een specifiek file eigenaarschap te mounten.
  Om deze optie te kunnen benutten moet de container draaien met `--user root`.
  (Het `start-notebook.sh` script voert `su jovyan` uit na het aanpassen van het gebruiker id.)
* `-e GRANT_SUDO=yes` - Geeft de gebruiker `jovyan` `sudo` zonder wachtwoord rechten.
  Dit is vooral nuttig voor het installeren van OS pakketten.
  Om deze optie te kunnen benutten moet de container draaien met `--user root`.
  (Het `start-notebook.sh` script voert `su jovyan` en voegt `jovyan` toe aan  sudoers.)
  **Je moet `sudo` alleen maar toestaan, al je de gebruiker vertrouwt of als
   de container op een geïsoleerde host draait.**
* `-v /een/host/folder/voor/werk:/home/jovyan/werk` - Host mount de standaard werk directory op de host
  werk te bewaren, zelfs wanneer de container wordt verwijderd en opnieuw aangemaakt (bijv.,
  bij een upgrade).

## SSL Certificaten

Je kunt SSL sleutel- en certificaat-bestanden in de container mounten en Jupyter Notebook
configureren om deze te gebruiken voor HTTPS verbindingen.
Bijvoorbeeld, om een host folder met `notebook.key` en `notebook.crt` te mounten:

```
docker run -d -p 8888:8888 \
    -v /een/host/folder:/etc/ssl/notebook \
    nijmegenr/datascience-notebook start-notebook.sh \
    --NotebookApp.keyfile=/etc/ssl/notebook/notebook.key
    --NotebookApp.certfile=/etc/ssl/notebook/notebook.crt
```

Je kunt echter ook een enkel PEM-bestand mounten, dat zowel de sleutel als het certificaat bevate.
Bijvoorbeeld:

```
docker run -d -p 8888:8888 \
    -v /een/host/folder/notebook.pem:/etc/ssl/notebook.pem \
    nijmegen/data-science start-notebook.sh \
    --NotebookApp.certfile=/etc/ssl/notebook.pem
```

Hoe dan ook verwacht Jupyter Notebook de sleutel en het certificaat in een base64-gecodeerd tekstbestand.
Het certificaat-bestand of -PEM kunnen een of meer certificaten bevatten
(bijv., server, tijdelijk en root).

Voor meer informatie over het gebruik van SSL zie:

* De [docker-stacks/examples](https://github.com/jupyter/docker-stacks/tree/master/examples) voor informatie over hoe
  je [Let's Encrypt](https://letsencrypt.org/) certificaten kunt gebruiken als je deze stacks wilt gebruiken
  op een openbaar netwerk.
* Het [jupyter_notebook_config.py](jupyter_notebook_config.py) bestand beschrijft how dit Docker image
  een self-signed certificaat aanmaakt.
* De [Jupyter Notebook documentatie](https://jupyter-notebook.readthedocs.io/en/latest/public_server.html#using-ssl-for-encrypted-communication)
  voor de best practices over het draaien van een publieke notebook server in zijn algemeenheid.

## Conda Omgevingen

De standaard Python 3.x [Conda omgeving](http://conda.pydata.org/docs/using/envs.html)
vind je in `/opt/conda`.
In `/opt/conda/envs/python2` is een tweede Python 2.x Conda omgeving.
Je kunt [overschakelen op de python2 omgeving](http://conda.pydata.org/docs/using/envs.html#change-environments-activate-deactivate)
in een shell door het volgend in te typen:

```
source activate python2
```

Om terug te keren naar de standaard omgeving:

```
source deactivate
```

De commando's `jupyter`, `ipython`, `python`, `pip`, `easy_install` en `conda` (onder andere)
zijn in beide omgevingen aanwezig.
Voor het gemak kun je pakketten installeren in een specifieke omgeving - ongeachte welke omgeving
op dat ogenblik actief is -  met dit soort commando's:

```
# installeer een pakket in de python2 omgeving
pip2 install some-package
conda install -n python2 een-pakket

# installeer een pakket in de standaard (python 3.x) omgeving
pip3 install some-package
conda install -n python3 een-pakket
```

## Alternatieve Commando's

### start-singleuser.sh

[JupyterHub](https://jupyterhub.readthedocs.io) vereist per gebruiker een
single-user instantie  van de Jupyter Notebook server.
Om deze stack te gebruiken op JupyterHub en [DockerSpawner](https://github.com/jupyter/dockerspawner),
moet je de image naam van de container specificeren en het standaard container
run commando overschrijven  in je `jupyterhub_config.py`:

```python
# Spawn gebruiker-containers van dit image
c.DockerSpawner.container_image = 'nijmegenr/data-science'

# Laat de Spawner het Docker run commando overschrijven
c.DockerSpawner.extra_create_kwargs.update({
	'command': '/usr/local/bin/start-singleuser.sh'
})
```

### start.sh

Het `start.sh` script ondersteunt dezelfde features als het standaard `start-notebook.sh` script (bijv., `GRANT_SUDO`), 
maar stelt je bovendien in staat om willekeurige commando's uit te voeren.
Bijvoorbeeld, om een tekst-gebaseerde `ipython` console in een container te draaien, doe je dit:

```
docker run -it --rm nijmegenr/data-science start.sh ipython
```

Dit script is met name handig om een nieuwe Dockerfile van dit image te maken en
additionele Jupyter applicaties te installeren met subcommando's als 
`jupyter console`, `jupyter kernelgateway` en `jupyter lab`.

### Andere

Je kunt ook willekeurige start commando's specificeren.
Wees er wel van bewust, dat mogelijk bepaalde features niet zullen werken (bijv.  `GRANT_SUDO`).
