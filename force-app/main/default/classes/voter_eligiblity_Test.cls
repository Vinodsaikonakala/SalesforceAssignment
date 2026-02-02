@IsTest
public class voter_eligiblity_Test {

    @IsTest
    static void testVoterEligibility() {
        System.assertEquals('you are eligible to vote',voter_eligiblity.is_eligibleforvote(25));
        System.assertEquals( 'you are not eligible to vote',voter_eligiblity.is_eligibleforvote(16));
        System.assertEquals('you are eligible to vote',voter_eligiblity.is_eligibleforvote(18));
    }
}