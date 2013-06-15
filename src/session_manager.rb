class SessionManager

	# Shared pref mode
	 PRIVATE_MODE = 0;
	
	# Sharedpref file name
	PREF_NAME = "Veerababu"
	
	# All Shared Preferences Keys
	IS_LOGIN = "IsLoggedIn"
	
	# User name (make variable public to access from outside)
	KEY_NAME = "name"
	
	# Email address (make variable public to access from outside)
	KEY_EMAIL = "email"

	def initialize(activity)
		@activity = activity
			#creating instance for SharedPreferences
		@pref = @activity.getSharedPreferences(PREF_NAME, PRIVATE_MODE)
			#creating Editor using SharedPreferences instance
		@editor = @pref.edit();
	end

		#creating Login Session
	def createLoginSession(name, email)
		# Storing login value as TRUE
		@editor.putBoolean(IS_LOGIN, true)
		
		# Storing name in pref
		@editor.putString(KEY_NAME, name)
		
		# Storing email in pref
		@editor.putString(KEY_EMAIL, email)
		
		# commit changes
		@editor.commit();
	end

		#Checking user is loged in or not
	def checkLogin
		# Check login status
		if(!self.isLoggedIn)
			# user is not logged in redirect him to Login Activity
			i = android.content.Intent.new
			i.setClassName($package_name, 'org.ruboto.session.authentication_app.AuthenticationAppActivity')
			@activity.startActivity(i)
			@activity.finish()
		end
	end

		#Getting stored session data
	def getUserDetails
		user = java.util.HashMap.new()
		# user name
		user.put(KEY_NAME, @pref.getString(KEY_NAME, nil))
		
		# user email id
		user.put(KEY_EMAIL, @pref.getString(KEY_EMAIL, nil))
		
		# return user
		return user;
	end

		# Clearing the session details
	def logoutUser
		# Clearing all data from Shared Preferences
		@editor.clear()
		@editor.commit()
		
		# After logout redirect user to Loing Activity
		i = android.content.Intent.new
		i.setClassName($package_name, 'org.ruboto.session.authentication_app.AuthenticationAppActivity')
		@activity.startActivity(i);
		@activity.finish()
	end

		# Checking for login
	def isLoggedIn
		return @pref.getBoolean(IS_LOGIN, false)
	end
end
