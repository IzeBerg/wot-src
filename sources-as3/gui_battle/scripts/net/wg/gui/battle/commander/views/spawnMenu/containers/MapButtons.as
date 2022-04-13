package net.wg.gui.battle.commander.views.spawnMenu.containers
{
   import flash.events.MouseEvent;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.SoundTypes;
   import net.wg.gui.battle.commander.views.spawnMenu.events.SpawnMenuEvent;
   import net.wg.gui.battle.commander.views.spawnMenu.items.StagedItem;
   import net.wg.gui.interfaces.ISoundButtonEx;
   
   public class MapButtons extends StagedItem
   {
       
      
      public var autoSetBtn:ISoundButtonEx = null;
      
      public var resetBtn:ISoundButtonEx = null;
      
      private var _autoSetBtnText:String;
      
      private var _resetBtnText:String;
      
      private var _isAutoSetBtnEnabled:Boolean;
      
      private var _isResetBtnEnabled:Boolean;
      
      public function MapButtons()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.autoSetBtn.addEventListener(MouseEvent.CLICK,this.onAutoSetBtnClicked);
         this.resetBtn.addEventListener(MouseEvent.CLICK,this.onResetBtnClicked);
      }
      
      override protected function onDispose() : void
      {
         this.autoSetBtn.removeEventListener(MouseEvent.CLICK,this.onAutoSetBtnClicked);
         this.resetBtn.removeEventListener(MouseEvent.CLICK,this.onResetBtnClicked);
         this.autoSetBtn.dispose();
         this.autoSetBtn = null;
         this.resetBtn.dispose();
         this.resetBtn = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.autoSetBtn.soundType = SoundTypes.RTS_SPAWN_MENU_AUTO_SET_BTN;
            this.resetBtn.soundType = SoundTypes.RTS_SPAWN_MENU_RESET_BTN;
         }
         if(isInvalid(InvalidationType.DATA | InvalidationType.SIZE))
         {
            this.autoSetBtn.label = this._autoSetBtnText;
            this.resetBtn.label = this._resetBtnText;
            this.autoSetBtn.enabled = this._isAutoSetBtnEnabled;
            this.resetBtn.enabled = this._isResetBtnEnabled;
         }
      }
      
      public function setLabels(param1:String, param2:String) : void
      {
         this._autoSetBtnText = param1;
         this._resetBtnText = param2;
         invalidateData();
      }
      
      public function set isAutoSetBtnEnabled(param1:Boolean) : void
      {
         this._isAutoSetBtnEnabled = param1;
         invalidateData();
      }
      
      public function set isResetBtnEnabled(param1:Boolean) : void
      {
         this._isResetBtnEnabled = param1;
         invalidateData();
      }
      
      private function onResetBtnClicked(param1:MouseEvent) : void
      {
         dispatchEvent(new SpawnMenuEvent(SpawnMenuEvent.RESET));
      }
      
      private function onAutoSetBtnClicked(param1:MouseEvent) : void
      {
         dispatchEvent(new SpawnMenuEvent(SpawnMenuEvent.AUTOSET));
      }
   }
}
