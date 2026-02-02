public class palindrome {
    public static String is_Palindrome(String Word) {
        if(Word == Word.reverse())
            return 'Is palindrome';
        else
            return 'not a Palindrome';
        }
    }