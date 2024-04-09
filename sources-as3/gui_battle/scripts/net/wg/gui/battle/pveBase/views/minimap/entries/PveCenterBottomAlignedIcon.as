package net.wg.gui.battle.pveBase.views.minimap.entries
{
   import flash.display.Sprite;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.ATLAS_CONSTANTS;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.infrastructure.managers.IAtlasManager;
   
   public class PveCenterBottomAlignedIcon extends BattleUIComponent
   {
       
      
      private var _atlasManager:IAtlasManager;
      
      private var _container:Sprite;
      
      public function PveCenterBottomAlignedIcon()
      {
         this._atlasManager = App.atlasMgr;
         super();
         this._container = new Sprite();
         addChild(this._container);
      }
      
      public function setIcon(param1:String) : void
      {
         this._atlasManager.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,param1,this._container.graphics,Values.EMPTY_STR,true,false,true);
         this._container.y = -this._container.height >> 1;
      }
      
      public function flip() : void
      {
         this._container.scaleX = -1;
      }
      
      override protected function onDispose() : void
      {
         if(this._container != null)
         {
            removeChild(this._container);
            this._container = null;
         }
         this._atlasManager = null;
         super.onDispose();
      }
   }
}
