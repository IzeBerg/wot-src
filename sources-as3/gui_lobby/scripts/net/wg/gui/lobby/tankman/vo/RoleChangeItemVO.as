package net.wg.gui.lobby.tankman.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class RoleChangeItemVO extends DAAPIDataClass
   {
       
      
      public var id:String = "";
      
      public var name:String = "";
      
      public var icon:String = "";
      
      public var tooltip:String = "";
      
      public var available:Boolean = true;
      
      public var current:Boolean = false;
      
      public var warningHeader:String = "";
      
      public var warningBody:String = "";
      
      public function RoleChangeItemVO(param1:Object)
      {
         super(param1);
      }
   }
}
