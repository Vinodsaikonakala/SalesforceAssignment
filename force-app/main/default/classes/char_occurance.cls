public class char_occurance {
    public static Integer char_no(String word, String letter){
        Integer letter_count = 0;
        Integer target = letter.charAt(0);
        for (Integer ch : word.getChars()) {
            if (ch == target)
                letter_count++;
        }
        return letter_count;
    }
}