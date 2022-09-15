package net.wg.gui.lobby.profile.components
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   
   public class PersonalScoreComponent extends Sprite
   {
       
      
      public var tfPersonalScore:CenteredLineIconText;
      
      public var icon:MovieClip;
      
      public var tooltipHitArea:MovieClip;
      
      public function PersonalScoreComponent()
      {
         super();
         this.tooltipHitArea.addEventListener(MouseEvent.ROLL_OVER,this.onTooltipHitAreaRollOverHandler,false,0,true);
         this.tooltipHitArea.addEventListener(MouseEvent.ROLL_OUT,this.onTooltipHitAreaRollOutHandler,false,0,true);
      }
      
      private static function hideToolTip() : void
      {
         App.toolTipMgr.hide();
      }
      
      public final function dispose() : void
      {
         this.onDispose();
      }
      
      protected function onDispose() : void
      {
         if(this.tfPersonalScore)
         {
            this.tfPersonalScore.parent.removeChild(this.tfPersonalScore);
            this.tfPersonalScore.dispose();
            this.tfPersonalScore = null;
         }
         if(this.icon)
         {
            this.icon.parent.removeChild(this.icon);
            this.icon = null;
         }
         if(this.tooltipHitArea)
         {
            this.tooltipHitArea.removeEventListener(MouseEvent.ROLL_OVER,this.onTooltipHitAreaRollOverHandler);
            this.tooltipHitArea.removeEventListener(MouseEvent.ROLL_OUT,this.onTooltipHitAreaRollOutHandler);
            this.tooltipHitArea = null;
         }
      }
      
      protected function showToolTip() : void
      {
         App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.GLOBAL_RATING,null);
      }
      
      private function layout() : void
      {
         this.tfPersonalScore.validateNow();
         this.tfPersonalScore.x = -this.tfPersonalScore.actualWidth >> 1;
      }
      
      public function set description(param1:String) : void
      {
         this.tfPersonalScore.description = param1;
         this.layout();
      }
      
      public function set text(param1:String) : void
      {
         this.tfPersonalScore.text = param1;
         this.layout();
      }
      
      private function onTooltipHitAreaRollOutHandler(param1:MouseEvent) : void
      {
         hideToolTip();
      }
      
      private function onTooltipHitAreaRollOverHandler(param1:MouseEvent) : void
      {
         this.showToolTip();
      }
   }
}
