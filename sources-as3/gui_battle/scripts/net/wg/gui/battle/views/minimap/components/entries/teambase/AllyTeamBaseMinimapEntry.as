package net.wg.gui.battle.views.minimap.components.entries.teambase
{
   import flash.display.Sprite;
   import net.wg.data.constants.generated.ATLAS_CONSTANTS;
   import net.wg.gui.battle.views.minimap.MinimapEntryController;
   import net.wg.gui.battle.views.minimap.components.entries.constants.TeamBaseMinimapEntryConst;
   import net.wg.gui.battle.views.minimap.components.entries.personal.PingFlashMinimapEntry;
   import net.wg.gui.battle.views.minimap.constants.MinimapColorConst;
   import net.wg.infrastructure.managers.IAtlasManager;
   
   public class AllyTeamBaseMinimapEntry extends PingFlashMinimapEntry
   {
      
      private static const DIVIDE_100:Number = 0.01;
      
      private static const CAPTURE_ALPHA:Number = 0.7;
       
      
      public var atlasPlaceholder:Sprite = null;
      
      public var marker:MinimapProgressCircle = null;
      
      private var _atlasManager:IAtlasManager;
      
      public function AllyTeamBaseMinimapEntry()
      {
         this._atlasManager = App.atlasMgr;
         super();
         this.marker.visible = false;
         this.marker.setIsAlly(false);
         MinimapEntryController.instance.registerScalableEntry(this);
      }
      
      override protected function SetAtlasPlaceholderVisible(param1:Boolean) : void
      {
         if(this.atlasPlaceholder == null)
         {
            return;
         }
         this.atlasPlaceholder.visible = param1;
      }
      
      override protected function onDispose() : void
      {
         MinimapEntryController.instance.unregisterScalableEntry(this);
         this.atlasPlaceholder = null;
         this._atlasManager = null;
         this.marker.dispose();
         this.marker = null;
         super.onDispose();
      }
      
      public function setPointNumber(param1:int) : void
      {
         this._atlasManager.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,TeamBaseMinimapEntryConst.ALLY_TEAM_BASE_ATLAS_ITEM_NAME + "_" + MinimapColorConst.GREEN + "_" + param1,this.atlasPlaceholder.graphics,"",true);
      }
      
      public function setProgress(param1:int) : void
      {
         this.atlasPlaceholder.alpha = param1 > 0 ? Number(CAPTURE_ALPHA) : Number(1);
         this.marker.visible = param1 > 0;
         this.marker.updateProgress(param1 * DIVIDE_100);
      }
   }
}
