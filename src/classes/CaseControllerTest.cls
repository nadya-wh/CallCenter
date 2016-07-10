@isTest
private class CaseControllerTest {
	

	private static final String MANAGER_ROLE_NAME = 'CC Manager';
	private static final String BOSS_ROLE_NAME = 'Boss';

	@isTest static void testGetCases() {
		CaseDataFactory.createCasesWithStatus('Closed');
		CaseDataFactory.createCasesWithStatus('New');

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