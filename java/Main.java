public class Main{
    public static void main(String[] args) {
        System.out.println("DSA");

        int[] arr = {10, 20, 30};
        System.out.println(arr[0]);

        for(int i : arr){
            System.out.println(i);
        }
        
        for(int i : arr){
            for(int j : arr){
                System.out.println(i + "," +j );
            }
        }
    }
}