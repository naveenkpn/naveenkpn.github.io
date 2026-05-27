---
layout: page-notitle
permalink: /publications/
title: Publications
description: 
nav: true
nav_order: 4
---

# Publications and Theses

##### Search within metadata (keywords, author names, year etc.)
{% include bib_search.liquid %}

Filter by: 
[#journals](#article) &nbsp; [#conferences](#inproceedings) &nbsp; [#patents](#patent) &nbsp; [#preprints](#preprint) &nbsp; [#thesis](#thesis) &nbsp; [#show all](#)


<div class="publications" id="journal-articles">

<center> <h4> <b> Journal articles </b> </h4> </center>

{% bibliography -f journals %}

</div>

<div class="publications" id="conference-papers">

<center> <h4> <b> Conference papers </b> </h4> </center>

{% bibliography -f conferencepapers %}

</div>

<div class="publications" id="patents">

<center> <h4> <b> Patents </b> </h4> </center>

{% bibliography -f patents %}

</div>

<div class="publications" id="preprints">

<center> <h4> <b> Preprints </b> </h4> </center>

{% bibliography -f eprints %}

</div>

<div class="publications" id="preprints">

<center> <h4> <b> PhD, MTech by research and MTech theses </b> </h4> </center>

{% bibliography -f theses %}

</div>
