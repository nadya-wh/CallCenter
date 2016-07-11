@isTest
private class CaseControllerTest {

	private static final String MANAGER_ROLE_NAME = 'CC Manager';
	private static final String BOSS_ROLE_NAME = 'Boss';
	private static final String NEW_STATUS = 'New';
	private static final String CLOSED_STATUS = 'Closed';
	private static final Integer RECORDS_COUNT = 2;

	@testSetup static void createNewCases() {
		createCasesWithStatus(NEW_STATUS);
	}
    
    @testSetup static void createClosedCases() {
		createCasesWithStatus(CLOSED_STATUS);
	}

	private static void createCasesWithStatus(String status) {
		List<Case> cases = new List<Case>();
		for (Integer i = 0; i < RECORDS_COUNT; i++) {
			Case c = new Case(Status = status);
			cases.add(c);
		}
		insert cases;
	}


	@isTest static void testGetCases() {
		CaseController caseController = new CaseController();

		System.assert(caseController.getCases().size() == 0);

		caseController.setChosenRole(MANAGER_ROLE_NAME);
		System.assertEquals(MANAGER_ROLE_NAME, caseController.getChosenRole());

		List<Case> managerCases = caseController.getCases();

		caseController.setChosenRole(BOSS_ROLE_NAME);
		List<Case> bossCases = caseController.getCases();

		for (Case c : bossCases) {
			System.assert(c.Status != 'Closed');
		}

		System.assertNotEquals(managerCases, bossCases);

	}

	
}