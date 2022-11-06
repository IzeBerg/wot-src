package net.wg.gui.battle.views.battleMessenger.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class BattleMessengerSettingsVO extends DAAPIDataClass
   {
       
      
      public var isHistoryEnabled:Boolean = false;
      
      public var numberOfMessagesInHistory:int = -1;
      
      public var inactiveStateAlpha:Number = -1;
      
      public var maxLinesCount:int = -1;
      
      public var lifeTime:int = -1;
      
      public var alphaSpeed:int = -1;
      
      public var maxMessageLength:int = -1;
      
      public var toolTipStr:String = "";
      
      public var lastMessageAlpha:Number = -1;
      
      public var recoveredLatestMessagesAlpha:Number = -1;
      
      public var recoveredMessagesLifeTime:int = -1;
      
      public function BattleMessengerSettingsVO(param1:Object)
      {
         super(param1);
      }
   }
}
