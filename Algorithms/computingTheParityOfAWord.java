public class computingTheParityOfAWord{
  public static short parity(long x){
    short result = 0;
    while (x != 0){
      result ^= (x & 1);
      x >>>= 1;        // unsigned shift right
    }
    return result;
  }

  public static void main(String[] args) {
    System.out.println(parity(0b01010101010101010101101010101010101010101101010L));			// output 0
    System.out.println(parity(0b01010101010101010101101010101010101010101101011L));			// output 1
  }
}