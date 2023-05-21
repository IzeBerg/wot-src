package net.wg.gui.battle.battleRoyale.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class RespawnMessageVO extends DAAPIDataClass
   {
       
      
      public var title:String = "";
      
      public var description:String = "";
      
      public var messageLinkage:String = "";
      
      public var time:int = -1;
      
      public var delay:int = -1;
      
      public var quickHide:Boolean = false;
      
      public function RespawnMessageVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
