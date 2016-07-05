public class RoleHelper {

	public RoleHelper() {
		
	}

	 public static Set<ID> getRoleSubordinateUsers(Id userId) {

	    Id roleId = [SELECT UserRoleId 
	    			FROM User 
	    			WHERE Id = :userId].UserRoleId;
	    Set<Id> allSubRoleIds = getSubRoleIds(roleId);
	    Map<Id, User> users = new Map<Id, User>([SELECT Id, Name 
	    										FROM User 
	    										WHERE UserRoleId IN :allSubRoleIds]);
  		return users.keySet();

    }

    	 public static Set<ID> getRoleSubordinateUsersForRoleName(String userRole) {

	    Id roleId = [SELECT Id 
	    			FROM UserRole 
	    			WHERE Name = :userRole].Id;
	    Set<Id> allSubRoleIds = getSubRoleIds(roleId);
	    Map<Id, User> users = new Map<Id, User>([SELECT Id, Name 
	    										FROM User 
	    										WHERE UserRoleId IN :allSubRoleIds]);
  		return users.keySet();

    }

    private static Set<ID> getSubRoleIds(ID roleId) {
	    Set<ID> currentRoleIds = new Set<ID>();
	    for (UserRole userRole : [SELECT Id 
	    						FROM UserRole 
	    						WHERE ParentRoleId = :roleId]) {
	    	currentRoleIds.add(userRole.Id);
		}
	    return currentRoleIds;

  	}

	public static Id getRoleId(String roleName) {
		UserRole role = [SELECT Id 
						FROM UserRole 
						WHERE Name = :roleName];
		return role != null ? role.Id : null; 
	}
}