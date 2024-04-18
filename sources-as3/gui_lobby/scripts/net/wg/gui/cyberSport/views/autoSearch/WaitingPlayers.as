package net.wg.gui.cyberSport.views.autoSearch
{
   import flash.display.MovieClip;
   import net.wg.data.constants.generated.CYBER_SPORT_ALIASES;
   import net.wg.gui.components.advanced.FieldSet;
   import net.wg.gui.components.advanced.IndicationOfStatus;
   import net.wg.gui.cyberSport.controls.WaitingAlert;
   import net.wg.gui.cyberSport.vo.AutoSearchVO;
   import net.wg.gui.cyberSport.vo.WaitingPlayersVO;
   
   public class WaitingPlayers extends StateViewBase
   {
       
      
      public var fieldSet:FieldSet;
      
      public var buttonsBG:MovieClip;
      
      public var player1:IndicationOfStatus = null;
      
      public var player2:IndicationOfStatus = null;
      
      public var player3:IndicationOfStatus = null;
      
      public var player4:IndicationOfStatus = null;
      
      public var player5:IndicationOfStatus = null;
      
      public var player6:IndicationOfStatus = null;
      
      public var player7:IndicationOfStatus = null;
      
      public var alertCmp:WaitingAlert;
      
      private var _players:Vector.<IndicationOfStatus> = null;
      
      public function WaitingPlayers()
      {
         super();
         this._players = new <IndicationOfStatus>[this.player1,this.player2,this.player3,this.player4,this.player5,this.player6,this.player7];
         this.buttonsBG.visible = false;
         cancelButton.visible = false;
      }
      
      override protected function getCancelLabel() : String
      {
         return CYBERSPORT.WINDOW_AUTOSEARCH_SEARCHCOMMAND_CANCELLBL;
      }
      
      override protected function getMainLabel() : String
      {
         return CYBERSPORT.WINDOW_AUTOSEARCH_WAITINGPLAYERS_MAINTEXT;
      }
      
      override protected function getSearchState() : String
      {
         return CYBER_SPORT_ALIASES.AUTO_SEARCH_WAITING_PLAYERS_STATE;
      }
      
      override public function changeButtonsState(param1:Boolean, param2:Boolean) : void
      {
         this.buttonsBG.visible = cancelButton.visible = param1;
         cancelButton.enabled = param1;
      }
      
      override protected function updateView() : void
      {
         super.updateView();
         this.buttonsBG.visible = cancelButton.visible = model.canInvokeAutoSearch;
         updateTime();
         startTimer();
         this.initPlayersState(model.playersReadiness);
      }
      
      override protected function onTimer() : void
      {
         super.onTimer();
         updateTime();
         startTimer();
      }
      
      override protected function onDispose() : void
      {
         if(this.fieldSet)
         {
            this.fieldSet.dispose();
            this.fieldSet = null;
         }
         if(this.alertCmp)
         {
            this.alertCmp.dispose();
            this.alertCmp = null;
         }
         this._players.splice(0,this._players.length);
         this._players = null;
         if(this.player1)
         {
            this.player1.dispose();
            this.player1 = null;
         }
         if(this.player2)
         {
            this.player2.dispose();
            this.player2 = null;
         }
         if(this.player3)
         {
            this.player3.dispose();
            this.player3 = null;
         }
         if(this.player4)
         {
            this.player4.dispose();
            this.player4 = null;
         }
         if(this.player5)
         {
            this.player5.dispose();
            this.player5 = null;
         }
         if(this.player6)
         {
            this.player6.dispose();
            this.player6 = null;
         }
         if(this.player7)
         {
            this.player7.dispose();
            this.player7 = null;
         }
         this.buttonsBG = null;
         super.onDispose();
      }
      
      override protected function onCancelButtonClick() : void
      {
         super.onCancelButtonClick();
         cancelButton.enabled = false;
      }
      
      override public function setData(param1:AutoSearchVO) : void
      {
         var _loc2_:WaitingPlayersVO = null;
         super.setData(param1);
         if(param1 != null && param1.extraData != null)
         {
            _loc2_ = new WaitingPlayersVO(param1.extraData);
            this.alertCmp.visible = _loc2_.showAlert;
            if(_loc2_.showAlert)
            {
               this.alertCmp.setData(_loc2_.alertTooltip,_loc2_.alertIcon);
            }
            _loc2_.dispose();
         }
      }
      
      private function initPlayersState(param1:Array) : void
      {
         var _loc2_:uint = param1.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if(param1[_loc3_] == null)
            {
               this._players[_loc3_].status = IndicationOfStatus.STATUS_LOCKED;
            }
            else
            {
               this._players[_loc3_].status = Boolean(param1[_loc3_]) ? IndicationOfStatus.STATUS_READY : IndicationOfStatus.STATUS_NORMAL;
            }
            _loc3_++;
         }
      }
   }
}
