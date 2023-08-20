---
layout: page
title: Server
permalink: /server/
---

<ul>
  {% for post in site.categories.server %}
    {% if post.url %}
      <li><a href="{{ post.url }}">{{ post.title }}</a></li>
    {% endif %}
  {% endfor %}
</ul>