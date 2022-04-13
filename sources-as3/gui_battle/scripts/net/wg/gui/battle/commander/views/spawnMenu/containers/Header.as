package net.wg.gui.battle.commander.views.spawnMenu.containers
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.commander.views.spawnMenu.items.StagedItem;
   import net.wg.gui.components.controls.UILoaderAlt;
   
   public class Header extends StagedItem
   {
       
      
      public var timerTF:TextField = null;
      
      public var titleTF:TextField = null;
      
      public var winConditionTF:TextField = null;
      
      public var mapNameTF:TextField = null;
      
      public var rtsIcon:MovieClip = null;
      
      public var mapIcon:UILoaderAlt = null;
      
      public var headerBg:MovieClip = null;
      
      public var preBattleTimerPoint:MovieClip = null;
      
      private var _isWaitingPlayers:Boolean = true;
      
      private var _mapName:String = null;
      
      private var _mapIconPath:String = "";
      
      private var _winConditionText:String = "";
      
      public function Header()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.winConditionTF.autoSize = TextFieldAutoSize.LEFT;
         this.mapNameTF.autoSize = TextFieldAutoSize.RIGHT;
         mouseEnabled = mouseChildren = false;
      }
      
      override protected function onDispose() : void
      {
         this.timerTF = null;
         this.titleTF = null;
         this.winConditionTF = null;
         this.mapNameTF = null;
         this.headerBg = null;
         this.rtsIcon = null;
         this.mapIcon = null;
         this.preBattleTimerPoint = null;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA | InvalidationType.SIZE))
         {
            this.timerTF.text = !!this._isWaitingPlayers ? INGAME_GUI.TIMER_WAITING : RTS_BATTLES.SPAWNMENU_HEADER_TIMERTITLE;
            this.titleTF.text = RTS_BATTLES.SPAWNMENU_HEADER_BATTLETYPETITLE;
            this.winConditionTF.text = this._winConditionText;
            if(this._mapIconPath)
            {
               this.mapIcon.source = this._mapIconPath;
            }
            if(this._mapName)
            {
               this.mapNameTF.text = this._mapName;
            }
         }
      }
      
      public function set isWaitingPlayers(param1:Boolean) : void
      {
         this._isWaitingPlayers = param1;
         invalidateData();
      }
      
      public function updateTextLabels(param1:String, param2:String) : void
      {
         this._mapName = param1;
         this._winConditionText = param2;
         invalidateData();
      }
      
      public function set mapIconPath(param1:String) : void
      {
         this._mapIconPath = param1;
         invalidateData();
      }
      
      public function get prebattleTimerY() : Number
      {
         return y + this.preBattleTimerPoint.y;
      }
   }
}
