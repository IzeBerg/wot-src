package net.wg.gui.battle.views.gameMessagesPanel.data
{
   import net.wg.data.constants.generated.GAME_MESSAGES_CONSTS;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.battle.views.epicMessagesPanel.data.FirstGeneralRankReachedMessageVO;
   import net.wg.gui.battle.views.epicMessagesPanel.data.HeadquarterAttackedMessageVO;
   import net.wg.gui.battle.views.epicMessagesPanel.data.HeadquarterDestroyedMessageVO;
   import net.wg.gui.battle.views.epicMessagesPanel.data.OverTimeMessageVO;
   import net.wg.gui.battle.views.epicMessagesPanel.data.RankUpMessageVO;
   import net.wg.gui.battle.views.epicMessagesPanel.data.SectorBaseContestedMessageVO;
   import net.wg.gui.battle.views.epicMessagesPanel.data.SectorBaseMessageVO;
   
   public class GameMessageVO extends DAAPIDataClass
   {
      
      private static const SECONDS_TO_MILISECONDS:Number = 1000;
      
      private static const MSG_DATA:String = "msgData";
       
      
      public var messageType:String = "";
      
      public var priority:int = -1;
      
      public var length:Number = -1;
      
      public var msgData:BaseGameMessageVO = null;
      
      private var _cachedMsgData:Object = null;
      
      public function GameMessageVO(param1:Object)
      {
         super(param1);
         this.convertMsgData();
      }
      
      override public function toString() : String
      {
         return "MessagesVO " + this.messageType + " " + this.priority + " " + this.length;
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == MSG_DATA)
         {
            this._cachedMsgData = param2;
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.msgData)
         {
            this.msgData.dispose();
            this.msgData = null;
         }
         this._cachedMsgData = null;
         super.onDispose();
      }
      
      private function convertMsgData() : void
      {
         switch(this.messageType)
         {
            case GAME_MESSAGES_CONSTS.WIN:
            case GAME_MESSAGES_CONSTS.DEFEAT:
            case GAME_MESSAGES_CONSTS.DRAW:
               this.msgData = new EndGameMessageVO(this._cachedMsgData);
               break;
            case GAME_MESSAGES_CONSTS.TIME_REMAINING_POSITIVE:
            case GAME_MESSAGES_CONSTS.TIME_REMAINING:
               this.msgData = new BaseGameMessageVO(this._cachedMsgData);
               break;
            case GAME_MESSAGES_CONSTS.OVERTIME:
               this.msgData = new OverTimeMessageVO(this._cachedMsgData);
               break;
            case GAME_MESSAGES_CONSTS.BASE_CAPTURED:
            case GAME_MESSAGES_CONSTS.BASE_CAPTURED_POSITIVE:
               this.msgData = new SectorBaseMessageVO(this._cachedMsgData);
               break;
            case GAME_MESSAGES_CONSTS.BASE_CONTESTED:
            case GAME_MESSAGES_CONSTS.BASE_CONTESTED_POSITIVE:
               this.msgData = new SectorBaseContestedMessageVO(this._cachedMsgData);
               break;
            case GAME_MESSAGES_CONSTS.RANK_UP:
               this.msgData = new RankUpMessageVO(this._cachedMsgData);
               break;
            case GAME_MESSAGES_CONSTS.OBJECTIVE_DESTROYED_POSITIVE:
            case GAME_MESSAGES_CONSTS.OBJECTIVE_DESTROYED:
               this.msgData = new HeadquarterDestroyedMessageVO(this._cachedMsgData);
               break;
            case GAME_MESSAGES_CONSTS.OBJECTIVE_UNDER_ATTACK_POSITIVE:
            case GAME_MESSAGES_CONSTS.OBJECTIVE_UNDER_ATTACK:
               this.msgData = new HeadquarterAttackedMessageVO(this._cachedMsgData);
               break;
            case GAME_MESSAGES_CONSTS.GENERAL_RANK_REACHED:
               this.msgData = new FirstGeneralRankReachedMessageVO(this._cachedMsgData);
               break;
            default:
               this.msgData = new BaseGameMessageVO(this._cachedMsgData);
         }
         this._cachedMsgData = null;
      }
      
      public function get duration() : int
      {
         return this.length * SECONDS_TO_MILISECONDS;
      }
   }
}
