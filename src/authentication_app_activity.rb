require 'ruboto/widget'
require 'ruboto/util/toast'
require 'ruboto/util/stack'

require 'session_manager'
require 'alert_manager'


require 'login'
require 'database'

class AuthenticationAppActivity
  def onCreate(bundle)
    super
		
	setTitle "Login and Logout Functionality in Ruboto"
	self.setContentView(Ruboto::R::layout::login_form)
    
	puts "Entered in Main"
		#getting button instance and assigning event to it
	signin_button = findViewById(Ruboto::R::id::btn_SignIn)
	signin_button.setOnClickListener(OnClickListener.new(self))
	
	signup_button = findViewById(Ruboto::R::id::btn_Signup)
	signup_button.setOnClickListener(OnClickListener.new(self))
  end

	def onResume
		super
			puts "entered in onResume"
		 dialog = android.app.ProgressDialog.show(self, 'Authentication Application', 'Loading...')
			Thread.with_large_stack 128 do
			  Database.setup(self)
			  run_on_ui_thread{dialog.message = 'Generating DB schema...'}

			  Database.migrate(self)
			  run_on_ui_thread{dialog.message = 'Populating table...'}

			  #Login.create(:name => 'veeru', :password => 'veeru', :fname => 'veerababu', :lname => 'e', :phnumber => '9989361462', :email => 'veeru4soft@gmail.com')

				dialog.dismiss
			end
	end
end

class OnClickListener
	@@uname = ''
	@@pwd = ''
	@@email = ''
	def initialize(activity)
		puts "Entered in OnClickListener"
		@activity = activity
	end
	def onClick(view)
		 session = SessionManager.new(@activity)
		 alert = AlertDialogManager.new              
        

		case view.getText().to_s
			when 'SignIn'
			
				# getting username and password values
			 username = @activity.findViewById(Ruboto::R::id::login_username)
			 password = @activity.findViewById(Ruboto::R::id::login_Password)
			 puts username
			 puts password
			 @uname_value = username.getText().to_s
			 @pwd_value = password.getText().to_s
			 puts @uname_value
			 puts @pwd_value

				Thread.with_large_stack 128 do
					begin
						puts "Printing uname"
						puts @uname_value
						puts "gathering uname and password"
						user_details = Login.find_by_name(@uname_value)
						@@uname = user_details.name
						@@pwd = user_details.password
						@@email = user_details.email
						puts @@uname
						puts @@pwd
						puts @@email
					rescue
						puts "Error"
					end			
				end
				

				if (@uname_value.length > 0 && @pwd_value.length > 0)
							
						sleep(5)						
						if ((@uname_value.casecmp(@@uname) == 0 )  && (@pwd_value.casecmp(@@pwd) == 0 ))
						
								# Creating user login session
								session.createLoginSession(@@uname, @@email);
						
								# Staring Resulted Activity
								i = android.content.Intent.new('android.intent.action.RESULTPAGE');
								@activity.startActivity(i)
								#@activity.finish()
								
								
								
						
						else
							# username / password doesn't match
							alert.showAlertDialog(@activity, "Login failed..", "Username/Password is incorrect")
						end	
						
				else
							# user didn't entered username or password
							alert.showAlertDialog(@activity, "Login failed..", "Please enter username and password")
				end 
			when 'SignUp'
					i = android.content.Intent.new('android.intent.action.SIGNUPFORM')
					@activity.startActivity(i)
					#@activity.finish()
					
		
		end            
	end
end
