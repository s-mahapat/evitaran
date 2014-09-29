/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package IAS.Class;

import java.text.DecimalFormat;

public class EnglishNumberToWords {

    private String[] tensNames = {
        "",
        " ten",
        " twenty",
        " thirty",
        " forty",
        " fifty",
        " sixty",
        " seventy",
        " eighty",
        " ninety"
    };
    private String[] numNames = {
        "",
        " one",
        " two",
        " three",
        " four",
        " five",
        " six",
        " seven",
        " eight",
        " nine",
        " ten",
        " eleven",
        " twelve",
        " thirteen",
        " fourteen",
        " fifteen",
        " sixteen",
        " seventeen",
        " eighteen",
        " nineteen"
    };

    private String convertLessThanOneThousand(int number) {
        String soFar;

        if (number % 100 < 20) {
            soFar = numNames[number % 100];
            number /= 100;
        } else {
            soFar = numNames[number % 10];
            number /= 10;

            soFar = tensNames[number % 10] + soFar;
            number /= 10;
        }
        if (number == 0) {
            return soFar;
        }
        return numNames[number] + " hundred" + soFar;
    }

    public String convertDouble(double number) {

        String string = String.valueOf(number);
        String[] parts = string.split("\\.");
        String part1 = parts[0];
        String part2 = parts[1];

        if (part2.length() == 1) {
            part2 = part2.concat("0");
        }

        long numBeforeDec = Integer.parseInt(part1);
        long numAfterDec = Integer.parseInt(part2);

        String finalConvWord = convertInteger(numBeforeDec);
        finalConvWord = "INDIAN RS. ".concat(finalConvWord);
        if (numAfterDec != 0) {
            String wordsAfterDec = convertInteger(numAfterDec);
            finalConvWord = finalConvWord.concat(" and " + wordsAfterDec + " Paise");
        }
        return finalConvWord.concat(" ONLY");
    }

    public String convertInteger(long number) {
        // 0 to 999 999 999 999
        if (number == 0) {
            return "zero";
        }

        String snumber = Long.toString(number);

        // pad with "0"
        String mask = "000000000000";
        DecimalFormat df = new DecimalFormat(mask);
        snumber = df.format(number);

        // XXXnnnnnnnnn 
        int billions = Integer.parseInt(snumber.substring(0, 3));
        // nnnXXXnnnnnn
        int millions = Integer.parseInt(snumber.substring(3, 6));
        // nnnnnnXXXnnn
        int hundredThousands = Integer.parseInt(snumber.substring(6, 9));
        // nnnnnnnnnXXX
        int thousands = Integer.parseInt(snumber.substring(9, 12));

        String tradBillions;
        switch (billions) {
            case 0:
                tradBillions = "";
                break;
            case 1:
                tradBillions = convertLessThanOneThousand(billions)
                        + " billion ";
                break;
            default:
                tradBillions = convertLessThanOneThousand(billions)
                        + " billion ";
        }
        String result = tradBillions;

        String tradMillions;
        switch (millions) {
            case 0:
                tradMillions = "";
                break;
            case 1:
                tradMillions = convertLessThanOneThousand(millions)
                        + " million ";
                break;
            default:
                tradMillions = convertLessThanOneThousand(millions)
                        + " million ";
        }
        result = result + tradMillions;

        String tradHundredThousands;
        switch (hundredThousands) {
            case 0:
                tradHundredThousands = "";
                break;
            case 1:
                tradHundredThousands = "one thousand ";
                break;
            default:
                tradHundredThousands = convertLessThanOneThousand(hundredThousands)
                        + " thousand ";
        }
        result = result + tradHundredThousands;

        String tradThousand;
        tradThousand = convertLessThanOneThousand(thousands);
        result = result + tradThousand;

        // remove extra spaces!
        return result.replaceAll("^\\s+", "").replaceAll("\\b\\s{2,}\\b", " ");
    }
//TESTING
//    public static void main(String[] args) {
//        System.out.println("*** " + EnglishNumberToWords.convertInteger(0));
//        System.out.println("*** " + EnglishNumberToWords.convertInteger(1));
//        System.out.println("*** " + EnglishNumberToWords.convertDouble(16.50));
//        System.out.println("*** " + EnglishNumberToWords.convertInteger(100));
//        System.out.println("*** " + EnglishNumberToWords.convertInteger(118));
//        System.out.println("*** " + EnglishNumberToWords.convertInteger(200));
//        System.out.println("*** " + EnglishNumberToWords.convertDouble(219.50));
//        System.out.println("*** " + EnglishNumberToWords.convertDouble(800));
//        System.out.println("*** " + EnglishNumberToWords.convertDouble(801));
//        System.out.println("*** " + EnglishNumberToWords.convertDouble(1316));
//        System.out.println("*** " + EnglishNumberToWords.convertDouble(1000000.99));
//        System.out.println("*** " + EnglishNumberToWords.convertDouble(2000000.21));

//    }
}
