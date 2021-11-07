package net.wg.gui.battle.views.minimap.components.entries.event
{
   import flash.display.Sprite;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.ATLAS_CONSTANTS;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.data.constants.generated.BATTLE_MINIMAP_CONSTS;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.infrastructure.managers.IAtlasManager;
   
   public class EventEnemyCampMinimapEntry extends BattleUIComponent
   {
       
      
      public var repliedAtlasPlaceholder:Sprite = null;
      
      public var atlasPlaceholder:Sprite = null;
      
      protected var _atlasManager:IAtlasManager;
      
      private var _isReplied:Boolean;
      
      public function EventEnemyCampMinimapEntry()
      {
         this._atlasManager = App.atlasMgr;
         super();
      }
      
      override protected function onDispose() : void
      {
         this.repliedAtlasPlaceholder = null;
         this.atlasPlaceholder = null;
         this._atlasManager = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._atlasManager.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,BATTLEATLAS.MAP_ENEMY_CAMP,this.atlasPlaceholder.graphics,Values.EMPTY_STR,true,false,true);
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
            this._atlasManager.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,BATTLEATLAS.EVENT_CAMP_REPLIED,this.repliedAtlasPlaceholder.graphics,Values.EMPTY_STR,true,false,true);
         }
         else
         {
            this.repliedAtlasPlaceholder.graphics.clear();
         }
      }
   }
}
