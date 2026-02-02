public class grade_check {
    public static string Grade(integer marks){
        if (marks >= 91 && marks <= 100)
            return 'A grade';
        else if (marks >= 71 && marks <= 90)
            return 'B grade';
        else if (marks >= 51 && marks <= 70)
            return 'C grade';
        else if (marks >= 35 && marks <= 50)
            return 'D grade';
        else if (marks >= 0 && marks <= 34)
            return 'Fail';
        else
            return 'Please enter valid marks';
    }
}