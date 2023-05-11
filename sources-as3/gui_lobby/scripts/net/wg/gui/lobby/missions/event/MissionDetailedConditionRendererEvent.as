package net.wg.gui.lobby.missions.event
{
   import flash.events.Event;
   
   public class MissionDetailedConditionRendererEvent extends Event
   {
      
      public static const BUY_CLICK:String = "buyClick";
       
      
      private var _tokenId:String;
      
      private var _questId:String;
      
      public function MissionDetailedConditionRendererEvent(param1:String, param2:String, param3:String, param4:Boolean = false, param5:Boolean = false)
      {
         super(param1,param4,param5);
         this._questId = param2;
         this._tokenId = param3;
      }
      
      override public function clone() : Event
      {
         return new MissionDetailedConditionRendererEvent(type,this.questId,this.tokenId,bubbles,cancelable);
      }
      
      public function get tokenId() : String
      {
         return this._tokenId;
      }
      
      public function get questId() : String
      {
         return this._questId;
      }
   }
}
