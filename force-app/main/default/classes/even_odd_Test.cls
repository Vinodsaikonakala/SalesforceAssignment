@IsTest
public class even_odd_Test {
    @IsTest
    static void testEvenOdd() {
        System.assertEquals('it is even number',even_odd.is_evenORodd(10));
        System.assertEquals('it is odd number',even_odd.is_evenORodd(7));
        System.assertEquals('it is zero',even_odd.is_evenORodd(0));
    }
}