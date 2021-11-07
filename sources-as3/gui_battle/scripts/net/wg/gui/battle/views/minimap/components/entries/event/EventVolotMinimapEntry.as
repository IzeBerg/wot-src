package net.wg.gui.battle.views.minimap.components.entries.event
{
   import flash.display.Sprite;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.ATLAS_CONSTANTS;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.data.constants.generated.BATTLE_MINIMAP_CONSTS;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.views.minimap.MinimapEntryController;
   import net.wg.infrastructure.managers.IAtlasManager;
   
   public class EventVolotMinimapEntry extends BattleUIComponent
   {
      
      private static const DISABLED_Y_OFFSET:int = -2;
      
      private static const ENABLED_Y_OFFSET:int = -1;
      
      private static const READY_Y_OFFSET:int = -9;
      
      private static const STATE_DISABLED:int = 1;
      
      private static const STATE_ENABLED:int = 2;
      
      private static const STATE_READY:int = 3;
       
      
      public var atlasPlaceholder:Sprite = null;
      
      public var repliedAtlasPlaceholder:Sprite = null;
      
      private var _atlasManager:IAtlasManager;
      
      private var _state:int;
      
      private var _isProgressActive:Boolean;
      
      private var _isReplied:Boolean;
      
      public function EventVolotMinimapEntry()
      {
         this._atlasManager = App.atlasMgr;
         super();
         MinimapEntryController.instance.registerScalableEntry(this);
      }
      
      override protected function onDispose() : void
      {
         this.atlasPlaceholder = null;
         this.repliedAtlasPlaceholder = null;
         this._atlasManager = null;
         MinimapEntryController.instance.unregisterScalableEntry(this);
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
      }
      
      public function setHidden(param1:Boolean) : void
      {
         visible = !param1;
      }
      
      public function setIconActive(param1:Boolean) : void
      {
         this._isProgressActive = param1;
         this.resolveProgressState();
      }
      
      public function setProgress(param1:int, param2:int) : void
      {
         this.resolveProgressState();
      }
      
      public function setState(param1:String) : void
      {
         var _loc2_:Boolean = param1 == BATTLE_MINIMAP_CONSTS.STATE_REPLY;
         if(this._isReplied == _loc2_)
         {
            return;
         }
         this._isReplied = _loc2_;
         if(_loc2_)
         {
            this._atlasManager.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,BATTLEATLAS.EVENT_VOLOT_REPLIED,this.repliedAtlasPlaceholder.graphics,Values.EMPTY_STR,true);
            this.repliedAtlasPlaceholder.x = -this.repliedAtlasPlaceholder.width >> 1;
            this.repliedAtlasPlaceholder.y = -this.repliedAtlasPlaceholder.height >> 1;
         }
         else
         {
            this.repliedAtlasPlaceholder.graphics.clear();
         }
      }
      
      public function setTimer() : void
      {
         this.handleIconState(STATE_READY);
      }
      
      private function resolveProgressState() : void
      {
         if(this._isProgressActive)
         {
            this.handleIconState(STATE_ENABLED);
         }
         else
         {
            this.handleIconState(STATE_DISABLED);
         }
      }
      
      private function handleIconState(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         if(this._state == param1)
         {
            return;
         }
         this._state = param1;
         switch(param1)
         {
            case STATE_DISABLED:
               _loc2_ = DISABLED_Y_OFFSET;
               _loc3_ = BATTLEATLAS.MAP_VOLOT_DISABLED;
               break;
            case STATE_ENABLED:
               _loc2_ = ENABLED_Y_OFFSET;
               _loc3_ = BATTLEATLAS.MAP_VOLOT_ENABLED;
               break;
            case STATE_READY:
               _loc2_ = READY_Y_OFFSET;
               _loc3_ = BATTLEATLAS.MAP_VOLOT_READY;
         }
         this._atlasManager.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,_loc3_,this.atlasPlaceholder.graphics,Values.EMPTY_STR,true);
         this.atlasPlaceholder.x = -this.atlasPlaceholder.width >> 1;
         this.atlasPlaceholder.y = (-this.atlasPlaceholder.height >> 1) + _loc2_;
      }
   }
}
