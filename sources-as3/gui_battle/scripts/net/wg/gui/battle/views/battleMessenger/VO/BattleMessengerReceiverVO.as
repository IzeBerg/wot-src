package net.wg.gui.battle.views.battleMessenger.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class BattleMessengerReceiverVO extends DAAPIDataClass
   {
       
      
      public var clientId:int = -1;
      
      public var labelStr:String = "";
      
      public var orderIndex:int = -1;
      
      public var isByDefault:Boolean = false;
      
      public var inputColor:int = -1;
      
      public var isEnabled:Boolean = false;
      
      public function BattleMessengerReceiverVO(param1:Object)
      {
         super(param1);
      }
   }
}
