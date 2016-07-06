public  class EmailTemplateHelper {
	

	public static Id getTemplateId(String name) {
		EmailTemplate et = [SELECT id 
					FROM EmailTemplate 
					WHERE name = :name];
		return et != null ? et.id : null;
	}

}