package net.wg.gui.components.controls.listselection
{
   public class ListSelectionDirection
   {
      
      public static const UP:ListSelectionDirection = new ListSelectionDirection(-1);
      
      public static const DOWN:ListSelectionDirection = new ListSelectionDirection(1);
       
      
      public var value:int;
      
      public function ListSelectionDirection(param1:int)
      {
         super();
         this.value = param1;
      }
   }
}
