@IsTest
public class char_occurance_Test {
    @IsTest
    static void testCharOccurance() {
        Integer result1 = char_occurance.char_no('salesforce', 's');
        System.assertEquals(2, result1, 's should occur 2 times');
    }
}