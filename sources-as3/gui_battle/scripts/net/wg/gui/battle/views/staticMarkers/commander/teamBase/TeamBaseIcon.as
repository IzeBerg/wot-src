package net.wg.gui.battle.views.staticMarkers.commander.teamBase
{
   import flash.display.MovieClip;
   import net.wg.gui.battle.components.BattleIconHolder;
   
   public class TeamBaseIcon extends BattleIconHolder
   {
      
      private static const PROGRESS_SCALE:Number = 0.5;
      
      private static const BASE_ID_SCALE:Number = 0.75;
      
      private static const BASE_ICN_SCALE:Number = 0.75;
      
      private static const TARGET_SCALE:Number = 0.9;
       
      
      public var progressCircle:TeamBaseProgressCircle = null;
      
      public var baseId:MovieClip = null;
      
      public var bg:MovieClip = null;
      
      public var targetHighlight:MovieClip = null;
      
      public function TeamBaseIcon()
      {
         super();
         this.bg.visible = true;
      }
      
      override protected function onDispose() : void
      {
         this.progressCircle.dispose();
         this.progressCircle = null;
         this.baseId = null;
         this.bg = null;
         this.targetHighlight = null;
         super.onDispose();
      }
      
      public function setBaseId(param1:Number) : void
      {
         this.baseId.gotoAndStop(param1);
      }
      
      public function setCapturePoints(param1:String, param2:Number) : void
      {
         this.progressCircle.updateProgress(param1,param2);
      }
      
      public function setInternalIconScale(param1:Number) : void
      {
         var _loc2_:Number = PROGRESS_SCALE * param1;
         this.progressCircle.scaleX = this.progressCircle.scaleY = _loc2_;
         _loc2_ = BASE_ID_SCALE * param1;
         this.baseId.scaleX = this.baseId.scaleY = _loc2_;
         _loc2_ = BASE_ICN_SCALE * param1;
         this.bg.scaleX = this.bg.scaleY = _loc2_;
         _loc2_ = TARGET_SCALE * param1;
         this.targetHighlight.scaleX = this.targetHighlight.scaleY = _loc2_;
      }
      
      public function setState(param1:String) : void
      {
         this.progressCircle.setState(param1);
      }
   }
}
