require 'ruboto/widget'
require 'ruboto/util/toast'
require 'ruboto/util/stack'

require 'database'
require 'login'

ruboto_import_widgets :Button, :LinearLayout, :TextView

# http://xkcd.com/378/

class Signupform
  def onCreate(bundle)
    super
    setTitle "Signup Form"
	self.setContentView(Ruboto::R::layout::signup_form)

	btn_reset = findViewById(Ruboto::R::id::bt_Reset)
	btn_save = findViewById(Ruboto::R::id::bt_Save) 
	btn_reset.setOnClickListener(OnClickListener.new(self))
	btn_save.setOnClickListener(OnClickListener.new(self))
  end
end

class OnClickListener
	
	def initialize(activity)
		@activity = activity
	end	
		#storing the data into the sqllite database
   def onClick(view)
			@username = @activity.findViewById(Ruboto::R::id::reg_Username)
			@password = @activity.findViewById(Ruboto::R::id::reg_Password)
			@firstname = @activity.findViewById(Ruboto::R::id::reg_FirstName)
			@lastname = @activity.findViewById(Ruboto::R::id::reg_Lastname)
			@phone = @activity.findViewById(Ruboto::R::id::reg_Phone)
			@email = @activity.findViewById(Ruboto::R::id::reg_Email)	
		
		case view.getText().to_s
			when 'Save'
			
				username_value = @username.getText().to_s
				password_value = @password.getText().to_s
				firstname_value = @firstname.getText().to_s
				lastname_value = @lastname.getText().to_s
				phone_value = @phone.getText().to_s
				email_value = @email.getText().to_s
				
						#printing all the values of a textboxes
				puts username_value
				puts password_value
				puts firstname_value
				puts lastname_value
				puts phone_value
				puts email_value

				puts "#######################"
				puts @phone.getText().class.inspect
		

				dialog = android.app.ProgressDialog.show(@activity, 'Creating Person', 'Loading...')
				Thread.with_large_stack 128 do
				  Login.create({:name => username_value, :password => password_value, :fname => firstname_value, :lname => lastname_value, :phnumber => phone_value, :email => email_value})

			
				i = android.content.Intent.new
				i.setClassName($package_name, 'org.ruboto.session.authentication_app.AuthenticationAppActivity')
				@activity.startActivity(i)	
				@activity.finish()
				
				 dialog.dismiss
				end

			when 'Reset'
				@username.setText('')
				@password.setText('')
				@firstname.setText('')
				@lastname.setText('')
				@phone.setText('')
				@email.setText('')
		end
	end
end
