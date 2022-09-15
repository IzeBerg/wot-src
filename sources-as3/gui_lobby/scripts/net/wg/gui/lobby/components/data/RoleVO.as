package net.wg.gui.lobby.components.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class RoleVO extends DAAPIDataClass
   {
       
      
      public var index:int = -1;
      
      public var icon:String = "";
      
      public function RoleVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
