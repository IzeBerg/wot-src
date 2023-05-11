package net.wg.gui.lobby.window
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ConfirmItemWindowBaseVO extends DAAPIDataClass
   {
       
      
      public var linkage:String = "";
      
      public var icon:String = "";
      
      public var name:String = "";
      
      public var description:String = "";
      
      public var defaultValue:Number = -1;
      
      public function ConfirmItemWindowBaseVO(param1:Object)
      {
         super(param1);
      }
   }
}
