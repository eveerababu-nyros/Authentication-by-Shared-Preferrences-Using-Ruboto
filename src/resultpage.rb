require 'ruboto/widget'
require 'ruboto/util/toast'

require 'session_manager'
require 'alert_manager'

ruboto_import_widgets :Button, :LinearLayout, :TextView



class Resultpage
  def onCreate(bundle)
    super
	setTitle "User Details Page"
	self.setContentView(Ruboto::R::layout::result_page)

		#getting button instance and applying event
	btnLogout = findViewById(Ruboto::R::id::btnLogout)
	alert = AlertDialogManager.new
	session = SessionManager.new(self)
	lblName = findViewById(Ruboto::R::id::lblName)
	lblEmail = findViewById(Ruboto::R::id::lblEmail)

				

	session.checkLogin
		
		 # get user data from session
    user = session.getUserDetails

		# name
    name = user.get(SessionManager::KEY_NAME);
        
        # email
    email = user.get(SessionManager::KEY_EMAIL);
		# displaying user data
    lblName.setText(android.text.Html.fromHtml("Name: <b>" + name + "</b>"));
    lblEmail.setText(android.text.Html.fromHtml("Email: <b>" + email + "</b>"));
	
	btnLogout.setOnClickListener(OnClickListener.new(self))
  end
end

class OnClickListener
	def initialize(activity)
		@activity = activity
	end
	def onClick(view)
		session = SessionManager.new(@activity)
		session.logoutUser();
	end
end
