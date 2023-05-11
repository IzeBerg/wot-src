package net.wg.gui.lobby.techtree.math
{
   public class MatrixPosition
   {
       
      
      public var row:int;
      
      public var column:int;
      
      public function MatrixPosition(param1:int = -1, param2:int = -1)
      {
         super();
         this.row = param1;
         this.column = param2;
      }
      
      public function toString() : String
      {
         return "[MatrixPosition: start = " + this.row + ", end = " + this.column + "]";
      }
   }
}
