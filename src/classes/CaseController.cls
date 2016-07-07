public with sharing class CaseController {

	private static final String MANAGER_ROLE_NAME = 'CC Manager';
	private static final String BOSS_ROLE_NAME = 'Boss';

	public String chosenRole;

	public CaseController() {
		
	}

	public void setChosenRole (String role) {
	    this.chosenRole = role;
	}
	    
	public String getChosenRole() {
	    return chosenRole;
	}

	public List<Case> getCases() {
		if (MANAGER_ROLE_NAME.equalsIgnoreCase(chosenRole)) {
			return getManagerCases();
		} else if (BOSS_ROLE_NAME.equalsIgnoreCase(chosenRole)) {
			return getBossCases();
		} else {
			return new List<Case>();
		}
	}

	public List<Case> getManagerCases() {
		return getCasesForRole(MANAGER_ROLE_NAME);
	}


	public List<Case> getBossCases() {
		List<Case> cases = [SELECT Id, Status, Description, 
							Owner.Id, Owner.Name, 
							Priority, CreatedDate
							FROM Case
							WHERE CreatedDate = LAST_N_DAYS:7 AND
							Status != 'Closed'];
		return cases;
	}


	private List<Case> getCasesForRole(String roleName) {
		Set<Id> subordinateRoleIds = RoleHelper.getRoleSubordinateUsersForRoleName(roleName);

		List<Case> cases = [SELECT Id, Status, Description, 
							Owner.Id, Owner.Name, 
							Priority, CreatedDate
							FROM Case
							WHERE OwnerId IN :subordinateRoleIds];
		return cases;
	}
}