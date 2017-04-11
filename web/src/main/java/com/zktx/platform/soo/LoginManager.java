package com.zktx.platform.soo;

import java.util.Collection;

import com.zktx.platform.entity.tb.User;

public class LoginManager {
	
	Collection<User> users;

	public User login(User user) {
		
		for (User u : users) {
			
			if(sameName(u, user)){
				return u;
			}
			
		}
		
		return null;
	}
	
	public boolean sameName(User inCollection, User loginUser) {
		if(loginUser.getName().equals(inCollection.getName()))
			return true;
		return false;
	}
	
}
