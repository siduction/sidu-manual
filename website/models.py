from django.db import models

# Create your models here.
class HttpSession(models.Model):
    name = models.CharField(max_length=64)
    language = models.CharField(max_length=8)
    
    def __unicode__(self):
        return self.name

class UserData(models.Model):
    key = models.CharField(max_length=128)
    value = models.TextField()
    session = models.ForeignKey(HttpSession, verbose_name="Session")
    def __unicode__(self):
        return self.key
    
class Search(models.Model):
    query = models.TextField()
    def __unicode__(self):
        return self.name[0:30] + '...' if len(self.name) > 33 else self.name 