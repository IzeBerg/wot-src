package net.wg.gui.dialogs
{
   public class ItemStatusData
   {
       
      
      public var id:String;
      
      public var status:Boolean;
      
      public function ItemStatusData(param1:String = null, param2:Boolean = false)
      {
         super();
         this.id = param1;
         this.status = param2;
      }
   }
}
