package net.wg.gui.battle.views.minimap.components.entries.pointsOfInterest
{
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.ATLAS_CONSTANTS;
   import net.wg.gui.battle.components.poi.components.PoiWithProgressStateCircle;
   import net.wg.gui.battle.views.minimap.components.entries.constants.PointsOfInterestMinimapEntryConst;
   import net.wg.infrastructure.events.ColorSchemeEvent;
   import net.wg.infrastructure.managers.IAtlasManager;
   import net.wg.infrastructure.managers.IColorSchemeManager;
   
   public class MinimapPoiProgressCircle extends PoiWithProgressStateCircle
   {
      
      private static const ICON_COOLDOWN_ALPHA:Number = 0.4;
       
      
      private var _atlasManager:IAtlasManager;
      
      private var _colorSchemeMgr:IColorSchemeManager = null;
      
      public function MinimapPoiProgressCircle()
      {
         this._atlasManager = App.atlasMgr;
         super();
      }
      
      override protected function initialize() : void
      {
         this._colorSchemeMgr = App.colorSchemeMgr;
         this._colorSchemeMgr.addEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onSchemasUpdatedHandler);
         this.updateColorBlind();
         super.initialize();
      }
      
      override protected function onDispose() : void
      {
         this._colorSchemeMgr.removeEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onSchemasUpdatedHandler);
         this._colorSchemeMgr = null;
         this._atlasManager = null;
         super.onDispose();
      }
      
      override protected function getIconCooldownAlpha() : Number
      {
         return ICON_COOLDOWN_ALPHA;
      }
      
      override protected function drawBackIcon() : void
      {
         super.drawBackIcon();
         this._atlasManager.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,PointsOfInterestMinimapEntryConst.POI_MARKER_BACK_ICON,highlight.graphics,Values.EMPTY_STR,true,false,true);
      }
      
      override protected function drawIconType() : void
      {
         super.drawIconType();
         var _loc1_:String = PointsOfInterestMinimapEntryConst.getPOIMarkerIconByType(iconType);
         this._atlasManager.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,_loc1_,icon.graphics,Values.EMPTY_STR,true,false,true);
      }
      
      override protected function updateColorBlind() : void
      {
         setColorBlindMode(this._colorSchemeMgr.getIsColorBlindS());
      }
      
      private function onSchemasUpdatedHandler(param1:ColorSchemeEvent) : void
      {
         this.updateColorBlind();
      }
   }
}
