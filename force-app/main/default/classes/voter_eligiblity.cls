public class voter_eligiblity {
    public static string is_eligibleforvote(integer age){
        if (age >= 18)
            return 'you are eligible to vote';
        else
            return 'you are not eligible to vote';
    }
}