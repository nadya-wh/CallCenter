public class ManagerEmailTemplateController {
	
	private static final String ROLE_NAME = 'CC Manager';

	public ManagerEmailTemplateController() {
		
	}


	public List<Case> getCases() {
		Set<Id> subordinateRoleIds = RoleHelper.getRoleSubordinateUsersForRoleName(ROLE_NAME);

		List<Case> cases = [SELECT Id, Status, Description, 
							Owner.Id, Owner.Name, 
							Priority, CreatedDate
							FROM Case
							WHERE OwnerId IN :subordinateRoleIds];
		return cases;
	}
}