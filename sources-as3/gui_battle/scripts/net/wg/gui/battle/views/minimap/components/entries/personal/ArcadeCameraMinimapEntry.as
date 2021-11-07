package net.wg.gui.battle.views.minimap.components.entries.personal
{
   import flash.display.CapsStyle;
   import flash.display.Graphics;
   import flash.display.JointStyle;
   import flash.display.LineScaleMode;
   import flash.display.Sprite;
   import net.wg.data.constants.generated.ATLAS_CONSTANTS;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.views.minimap.MinimapEntryController;
   import net.wg.gui.battle.views.minimap.components.entries.constants.PersonalMinimapEntryConst;
   import net.wg.gui.battle.views.minimap.components.entries.interfaces.IMinimapEntryWithNonScaleContent;
   import net.wg.infrastructure.managers.IAtlasManager;
   
   public class ArcadeCameraMinimapEntry extends BattleUIComponent implements IMinimapEntryWithNonScaleContent
   {
      
      private static const LINE_COLOR:uint = 15907381;
      
      private static const LINE_OPACITY:Number = 0.8;
      
      private static const LINE_THICKNESS:Number = 1;
      
      private static const LINE_LENGTH:Number = 1330;
      
      private static const LINE_DASH_LENGTH:Number = 18;
      
      private static const LINE_SPACE_LENGTH:Number = 5;
       
      
      public var directionPlaceholder:Sprite = null;
      
      public var directionLinePlaceholder:Sprite = null;
      
      private var _atlasManager:IAtlasManager;
      
      public function ArcadeCameraMinimapEntry()
      {
         this._atlasManager = App.atlasMgr;
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._atlasManager.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,PersonalMinimapEntryConst.GREEN_DIRECTION_ATLAS_ITEM_NAME,this.directionPlaceholder.graphics,"",true);
         var _loc1_:Graphics = this.directionLinePlaceholder.graphics;
         _loc1_.lineStyle(LINE_THICKNESS,LINE_COLOR,LINE_OPACITY,false,LineScaleMode.VERTICAL,CapsStyle.SQUARE,JointStyle.ROUND);
         var _loc2_:Number = LINE_LENGTH;
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         _loc1_.moveTo(_loc3_,-_loc4_);
         while(_loc2_ > 0)
         {
            _loc4_ += LINE_DASH_LENGTH;
            _loc2_ -= LINE_DASH_LENGTH;
            _loc1_.lineTo(_loc3_,-_loc4_);
            _loc4_ += LINE_SPACE_LENGTH;
            _loc1_.moveTo(_loc3_,-_loc4_);
            _loc2_ -= LINE_SPACE_LENGTH;
         }
         _loc1_.moveTo(0,-LINE_LENGTH);
         MinimapEntryController.instance.registerScalableEntry(this,true);
      }
      
      public function setContentNormalizedScale(param1:Number) : void
      {
         if(param1 != this.directionLinePlaceholder.scaleX)
         {
            this.directionLinePlaceholder.scaleX = this.directionLinePlaceholder.scaleY = param1;
         }
      }
      
      public function showDirectionLine() : void
      {
         this.directionLinePlaceholder.visible = true;
      }
      
      public function hideDirectionLine() : void
      {
         this.directionLinePlaceholder.visible = false;
      }
      
      override protected function onDispose() : void
      {
         MinimapEntryController.instance.unregisterScalableEntry(this,true);
         this.directionLinePlaceholder = null;
         this.directionPlaceholder = null;
         this._atlasManager = null;
         super.onDispose();
      }
   }
}
