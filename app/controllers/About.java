package controllers;

import org.h2.engine.Session;

import play.mvc.Controller;
import play.mvc.Http;
import play.mvc.Result;
import play.mvc.Security;
import views.html.*;
import models.*;
import play.mvc.Http.Context;

public class About extends Controller{
	
	public static Result display(String lang){
		
		if(lang.equals("english")){
			if(session().containsKey("email"))
				return ok(about.render(User.find.byId(session().get("email"))));
			else{
				User guest = new User("Guest","dummyEmail","dummyPassword");
				return ok(about.render(guest));
			}	
		}else if(lang.equals("farsi")){
			if(session().containsKey("email"))
				return ok(views.html.farsiEdition.about.render(User.find.byId(session().get("email"))));
			else{
				User guest = new User("Guest","dummyEmail","dummyPassword");
				return ok(views.html.farsiEdition.about.render(guest));
			}
		}
		else{
			//if neither english nor farsi is selected
			return badRequest("ERROR : The entered Language is not supported! PLease choose either Farsi or English");
		}
	
	
	
	}
}
