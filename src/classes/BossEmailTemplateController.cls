public class BossEmailTemplateController {


	public BossEmailTemplateController() {
		
	}

	public List<Case> getCases() {
		List<Case> cases = [SELECT Id, Status, Description, 
							Owner.Id, Owner.Name, 
							Priority, CreatedDate
							FROM Case
							WHERE CreatedDate = LAST_N_DAYS:7 AND
							Status != 'Closed'];
		return cases;
	}
}