# DRF-metatrader
    Getting the data from indicator MQL5 with Django Rest framework


<BR/>
<div class="highlight highlight-source-js"><pre>
Django
</pre></div>
Django is a high-level Python Web framework that encourages rapid development and clean, pragmatic design. Built by experienced developers, it takes care of much of the hassle of Web development, so you can focus on writing your app without needing to reinvent the wheel. It’s free and open source.
<BR/>
<BR/>


<div class="highlight highlight-source-js">
<pre>
Django REST framework (DRF)
</pre>
</div>
Django REST framework is a powerful and flexible toolkit for building Web APIs.<BR/>

Some reasons you might want to use REST framework:<BR/>

The Web browsable API is a huge usability win for your developers.<BR/>
Authentication policies including packages for OAuth1a and OAuth2.<BR/>
Serialization that supports both ORM and non-ORM data sources.<BR/>
Customizable all the way down - just use regular function-based views if you don't need the more powerful features.
Extensive documentation, and great community support.<BR/>
Used and trusted by internationally recognised companies including Mozilla, Red Hat, Heroku, and Eventbrite.<BR/>
</div>


<div class="highlight highlight-source-js">
<pre>
Postman
</pre>
</div>
Postman Galaxy: The Global Virtual API Conference
<BR/>
Postman Galaxy is a global, virtual Postman user conference. From February 2 to 4, 2021, we'll gather the world's most enthusiastic API users and developers for a rocketload of action-packed online event activities and content about all things API.

</div>


<div class="highlight highlight-source-js">
<pre>
Install
</pre>
</div>
    virtualenv myenv<BR/>
    source myenv/bin/activate<BR/>
    pip3 install django gunicorn mysqlclient<BR/>
    django-admin startproject core .<BR/>
    manage.py startapp api<BR/>
    pip install djangorestframework<BR/>
</div>

<BR/>
<BR/>


<div class="highlight highlight-source-js">
<pre>
Postman Raw jason
</pre>
</div>
[<BR/>
    {"time_frame":"D1","title": "Fractal_upper","symbol_name": "EURUSD", "type":"upper","time_request":"2020-12-23 00:00","price":12340.0},<BR/>
    {"time_frame":"D1","title": "Fractal_upper","symbol_name": "EURUSD", "type":"upper","time_request":"2020-12-14 00:00","price":12690.0}<BR/>
]<BR/>
</div>

<BR/>
<BR/>


<div class="highlight highlight-source-js">
<pre>
Documents
</pre>
</div>
<div>
https://www.django-rest-framework.org
<BR/>
</pre>
</div>
<BR/>
<BR/>