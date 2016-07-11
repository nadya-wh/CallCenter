@isTest
private class RoleHelperTest {

	
	@isTest static void testGetRoleId() {
		List<UserRole> roles = [SELECT Id, Name 
								FROM UserRole];
		for (UserRole role : roles) {
			System.assertEquals(role.Id, RoleHelper.getRoleId(role.Name));
		}


	}

	
}