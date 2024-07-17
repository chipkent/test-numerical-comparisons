public class Compare {
    private static final boolean comp(final String op, final double v1, final double v2){
        boolean result;
        switch (op) {
            case "==":
                return v1 == v2;
            case "!=":
                return v1 != v2;
            case ">":
                return v1 > v2;
            case ">=":
                return v1 >= v2;
            case "<":
                return v1 < v2;
            case "<=":
                return v1 <= v2;
            case "hashCode==":
                return Double.hashCode(v1) == Double.hashCode(v2);
            default:
                throw new IllegalArgumentException("Invalid operation: " + op);
        }
    }

    private static final String fmt(final String s){
        // format the string to be 12 characters wide
        return String.format("%1$12s", s);
    }

    public static void main(String[] args) {
        double[] values = { -0.0, 0.0, Double.NaN, -Double.NaN, Double.POSITIVE_INFINITY, Double.NEGATIVE_INFINITY };
        String[] operations = { "==", "!=", ">", ">=", "<", "<=", "hashCode==" };

        // Create the table header
        System.out.print(fmt("lang") + "," + fmt("v1") + "," + fmt("v2"));
        for (String op : operations) {
            System.out.print("," + fmt(op));
        }
        System.out.println();

        // Create the table rows
        for (double v1 : values) {
            for (double v2 : values) {
                System.out.print(fmt("Java") + fmt(Double.toString(v1)) + "," + fmt(Double.toString(v2)));
                for (String op : operations) {
                    final boolean result = comp(op, v1, v2);
                    final String resultStr = result ? "True" : "False";
                    System.out.print("," + fmt(resultStr));
                }
                System.out.println();
            }
        }




        // Create the table header
        System.out.print("| lang | v1 | v2 | ");
        for (String op : operations) {
            System.out.print(op + " | ");
        }
        System.out.println();

        // Create the separator for the table header
        for (int i = 0; i < operations.length + 3; i++) {
            System.out.print("| --- ");
        }
        System.out.println("|");

        // Create the table rows
        for (double v1 : values) {
            for (double v2 : values) {
                System.out.printf("| %s | %.2f | %.2f | ", "Java", v1, v2);
                for (String op : operations) {
                    final boolean result = comp(op, v1, v2);
                    final String resultStr = result ? "True" : "False";
                    System.out.print(resultStr + " | ");
                }
                System.out.println();
            }
        }
    }
}