package net.wg.gui.battle.eventBattle.views.minimap.entries
{
   import flash.display.CapsStyle;
   import flash.display.LineScaleMode;
   import flash.display.Sprite;
   import net.wg.data.constants.generated.ATLAS_CONSTANTS;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.gui.battle.eventBattle.views.eventPlayersPanel.comps.EventTimerAnimHelper;
   import net.wg.gui.battle.eventBattle.views.eventPlayersPanel.comps.IEventTimerAnimation;
   import net.wg.gui.utils.GraphicsUtilities;
   
   public class EventBombMinimapEntry extends EventIndexedMinimapEntry implements IEventTimerAnimation
   {
      
      private static const LINE_THICKNESS:Number = 3;
      
      private static const LINE_COLOR:uint = 9753343;
      
      private static const CIRCLE_RADIUS:uint = 15;
      
      private static const ARC_START_ANGLE:Number = Math.PI / 2;
      
      private static const CIRCLE_RAD_LENGTH:Number = 2 * Math.PI;
       
      
      public var circleAnim:Sprite = null;
      
      private var _animHelper:EventTimerAnimHelper = null;
      
      public function EventBombMinimapEntry()
      {
         super();
         this._animHelper = new EventTimerAnimHelper(this);
      }
      
      override protected function onDispose() : void
      {
         this._animHelper.dispose();
         this._animHelper = null;
         this.circleAnim = null;
         super.onDispose();
      }
      
      public function setIsCaptured(param1:Boolean) : void
      {
         _atlasManager.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,!!param1 ? BATTLEATLAS.WT_HUNTER : BATTLEATLAS.WT_BOMB,placeholder.graphics,"",true,false,true);
      }
      
      public function setBombTimer(param1:Number, param2:Number, param3:Number) : void
      {
         this._animHelper.setTime(param1,param2,param3);
      }
      
      public function updateProgress(param1:Number, param2:int) : void
      {
         this.circleAnim.graphics.clear();
         this.circleAnim.graphics.lineStyle(LINE_THICKNESS,LINE_COLOR,1,false,LineScaleMode.NONE,CapsStyle.NONE);
         var _loc3_:Number = (1 - param1) * CIRCLE_RAD_LENGTH;
         GraphicsUtilities.drawArc(this.circleAnim.graphics,0,0,ARC_START_ANGLE,_loc3_,CIRCLE_RADIUS);
      }
   }
}
