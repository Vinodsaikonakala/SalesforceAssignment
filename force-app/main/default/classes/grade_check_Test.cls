@IsTest
public class grade_check_Test {
    @IsTest
    static void testGradeMethod() {
        System.assertEquals('A grade', grade_check.Grade(95));
        System.assertEquals('B grade', grade_check.Grade(80));
        System.assertEquals('C grade', grade_check.Grade(60));
        System.assertEquals('D grade', grade_check.Grade(45));
        System.assertEquals('Fail', grade_check.Grade(20));
        System.assertEquals('Please enter valid marks', grade_check.Grade(120));
        System.assertEquals('Please enter valid marks', grade_check.Grade(-5));
    }
}