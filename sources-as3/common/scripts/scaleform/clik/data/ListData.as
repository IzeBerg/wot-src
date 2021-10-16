package scaleform.clik.data
{
   public class ListData
   {
       
      
      public var index:uint = 0;
      
      public var label:String = "Empty";
      
      public var selected:Boolean = false;
      
      public function ListData(param1:uint, param2:String = "Empty", param3:Boolean = false)
      {
         super();
         this.index = param1;
         this.label = param2;
         this.selected = param3;
      }
      
      public function toString() : String
      {
         return "[ListData " + this.index + ", " + this.label + ", " + this.selected + "]";
      }
   }
}
