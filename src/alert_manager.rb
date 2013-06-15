java_import "android.app.AlertDialog"

class AlertDialogManager
	 def showAlertDialog(activity, title, message) 
		alertbox = android.app.AlertDialog::Builder.new(activity)
	    alertbox.setTitle(title)
	    alertbox.setMessage(message)
	    alertbox.setNeutralButton("OK", nil)
	    alert = alertbox.create()
	    alert.show()
	end
end
