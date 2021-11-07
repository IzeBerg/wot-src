package net.wg.gui.battle.views.minimap.components.entries.personal
{
   import flash.display.Sprite;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.generated.ATLAS_CONSTANTS;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.views.minimap.MinimapEntryController;
   import net.wg.gui.battle.views.minimap.components.entries.constants.PersonalMinimapEntryConst;
   import net.wg.gui.battle.views.minimap.components.entries.interfaces.IMinimapEntryWithNonScaleContent;
   import net.wg.infrastructure.managers.IAtlasManager;
   
   public class ViewPointMinimapEntry extends BattleUIComponent implements IMinimapEntryWithNonScaleContent
   {
      
      private static const YAW_CORRECTION_ANGLE:Number = 180;
      
      private static const INVALID_YAW_LIMIT:int = InvalidationType.SYSTEM_FLAGS_BORDER << 1;
       
      
      public var sectorLeft:Sprite = null;
      
      public var sectorRight:Sprite = null;
      
      public var arrowPlaceholder:Sprite = null;
      
      private var _atlasManager:IAtlasManager;
      
      private var _leftYawLimit:Number = -1;
      
      private var _rightYawLimit:Number = -1;
      
      private var _isLimitUpdated:Boolean = false;
      
      public function ViewPointMinimapEntry()
      {
         this._atlasManager = App.atlasMgr;
         super();
         this.clearYawLimit();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._atlasManager.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,PersonalMinimapEntryConst.ARROW_ATLAS_ITEM_NAME,this.arrowPlaceholder.graphics,"",true);
         this._atlasManager.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,PersonalMinimapEntryConst.VIEW_SECTOR_LINE_ATLAS_ITEM_NAME,this.sectorLeft.graphics,"",true);
         this._atlasManager.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,PersonalMinimapEntryConst.VIEW_SECTOR_LINE_ATLAS_ITEM_NAME,this.sectorRight.graphics,"",true);
         MinimapEntryController.instance.registerScalableEntry(this,true);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INVALID_YAW_LIMIT) && this._isLimitUpdated)
         {
            this.sectorLeft.rotation = this._leftYawLimit - YAW_CORRECTION_ANGLE;
            this.sectorLeft.visible = true;
            this.sectorRight.rotation = this._rightYawLimit - YAW_CORRECTION_ANGLE;
            this.sectorRight.visible = true;
            this._isLimitUpdated = false;
         }
      }
      
      override protected function onDispose() : void
      {
         this.sectorLeft = null;
         this.sectorRight = null;
         this.arrowPlaceholder = null;
         this._atlasManager = null;
         MinimapEntryController.instance.unregisterScalableEntry(this,true);
         super.onDispose();
      }
      
      public function clearYawLimit() : void
      {
         this.sectorLeft.visible = false;
         this.sectorRight.visible = false;
      }
      
      public function setContentNormalizedScale(param1:Number) : void
      {
         if(this.sectorLeft.scaleX != param1)
         {
            this.sectorLeft.scaleX = this.sectorLeft.scaleY = this.sectorRight.scaleX = this.sectorRight.scaleY = param1;
         }
      }
      
      public function setYawLimit(param1:Number, param2:Number) : void
      {
         this._leftYawLimit = param1;
         this._rightYawLimit = param2;
         this._isLimitUpdated = true;
         invalidate(INVALID_YAW_LIMIT);
      }
   }
}
