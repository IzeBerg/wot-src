package net.wg.gui.battle.views.minimap.components.entries.scenario
{
   import flash.display.MovieClip;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.ATLAS_CONSTANTS;
   import net.wg.gui.battle.components.BaseProgressCircle;
   import net.wg.gui.battle.views.minimap.components.entries.constants.PointsOfInterestMinimapEntryConst;
   import net.wg.gui.battle.views.minimap.components.entries.constants.ScenarioMinimapEntryConst;
   import net.wg.infrastructure.events.ColorSchemeEvent;
   import net.wg.infrastructure.managers.IAtlasManager;
   import net.wg.infrastructure.managers.IColorSchemeManager;
   
   public class ScenarioMinimapProgressCircle extends BaseProgressCircle
   {
      
      private static const NORMAL_STATE:String = "normal";
      
      private static const PRECISION:Number = 0.005;
      
      private static const INV_FRAME:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 1;
       
      
      public var icon:MovieClip = null;
      
      public var highlight:MovieClip = null;
      
      private var _progress:Number = 0;
      
      private var _atlasManager:IAtlasManager;
      
      private var _colorSchemeMgr:IColorSchemeManager;
      
      public function ScenarioMinimapProgressCircle()
      {
         this._atlasManager = App.atlasMgr;
         this._colorSchemeMgr = App.colorSchemeMgr;
         super();
      }
      
      override public function updateProgress(param1:Number) : void
      {
         if(Math.abs(this._progress - param1) >= PRECISION)
         {
            this._progress = param1;
            currentProgressFrame = this._progress * SEMI_LAST_FRAME >> 0;
            invalidate(INV_FRAME);
         }
      }
      
      override protected function initialize() : void
      {
         this._colorSchemeMgr.addEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onSchemasUpdatedHandler);
         this.updateColorBlind();
         super.initialize();
      }
      
      override protected function draw() : void
      {
         var _loc1_:String = null;
         super.draw();
         if(isInvalid(InvalidationType.STATE))
         {
            _loc1_ = !!colorblindMode ? COLORBLIND_STATE : NORMAL_STATE;
            if(state != _loc1_)
            {
               state = _loc1_;
            }
            invalidate(INV_FRAME);
         }
         if(isInvalid(INV_FRAME))
         {
            if(currentFrameLabel != state)
            {
               gotoAndStop(state);
            }
            if(progressCircle.currentFrame != curFrame)
            {
               progressCircle.gotoAndStop(curFrame);
            }
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.drawIconType();
         this.drawBackIcon();
      }
      
      override protected function onDispose() : void
      {
         this._colorSchemeMgr.removeEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onSchemasUpdatedHandler);
         this._atlasManager = null;
         this.icon = null;
         this.highlight = null;
         this._colorSchemeMgr = null;
         super.onDispose();
      }
      
      private function updateColorBlind() : void
      {
         this.setColorBlindMode(this._colorSchemeMgr.getIsColorBlindS());
      }
      
      private function setColorBlindMode(param1:Boolean) : void
      {
         if(colorblindMode != param1)
         {
            colorblindMode = param1;
            invalidateState();
         }
      }
      
      private function drawIconType() : void
      {
         this._atlasManager.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,ScenarioMinimapEntryConst.SCENARIO_MARKER_ICON,this.icon.graphics,Values.EMPTY_STR,true,false,true);
      }
      
      private function drawBackIcon() : void
      {
         this._atlasManager.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,PointsOfInterestMinimapEntryConst.POI_MARKER_BACK_ICON,this.highlight.graphics,Values.EMPTY_STR,true,false,true);
      }
      
      private function onSchemasUpdatedHandler(param1:ColorSchemeEvent) : void
      {
         this.updateColorBlind();
      }
   }
}
