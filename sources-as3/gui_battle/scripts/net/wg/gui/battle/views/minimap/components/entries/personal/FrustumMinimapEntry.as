package net.wg.gui.battle.views.minimap.components.entries.personal
{
   import flash.display.CapsStyle;
   import flash.display.Graphics;
   import flash.display.JointStyle;
   import flash.display.LineScaleMode;
   import flash.display.Sprite;
   import net.wg.gui.battle.components.BattleUIComponent;
   
   public class FrustumMinimapEntry extends BattleUIComponent
   {
      
      private static const LINE_COLOR:uint = 15907381;
      
      private static const LINE_OPACITY:Number = 0.8;
      
      private static const LINE_THICKNESS:Number = 1;
      
      private static const LINE_LENGTH:Number = 1330;
      
      private static const LINE_DASH_LENGTH:Number = 18;
      
      private static const LINE_SPACE_LENGTH:Number = 5;
       
      
      public var directionLinePlaceholder:Sprite = null;
      
      public function FrustumMinimapEntry()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
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
      }
      
      override protected function onDispose() : void
      {
         this.directionLinePlaceholder = null;
      }
      
      public function setCameraInfo(param1:Array) : void
      {
         this.directionLinePlaceholder.x = param1[0];
         this.directionLinePlaceholder.y = param1[1];
         this.directionLinePlaceholder.rotation = param1[2];
      }
      
      public function setFrustumPoints(param1:Array) : void
      {
         graphics.clear();
         graphics.lineStyle(1,65280);
         var _loc2_:Number = 0;
         while(_loc2_ < param1.length)
         {
            if(_loc2_ == 0)
            {
               graphics.moveTo(param1[_loc2_][0],param1[_loc2_][1]);
            }
            else
            {
               graphics.lineTo(param1[_loc2_][0],param1[_loc2_][1]);
            }
            _loc2_++;
         }
         graphics.lineTo(param1[0][0],param1[0][1]);
      }
   }
}
