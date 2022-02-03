package net.wg.gui.components.questProgress
{
   import flash.display.Sprite;
   import flash.text.TextField;
   
   public class QuestProgressOrConditionTab extends QuestProgressOrCondition
   {
      
      private static const BG_HORIZONTAL_GAP:int = 60;
      
      private static const MIN_BG_WIDTH:int = 87;
      
      private static const DS_DISTANCE:Number = 0;
      
      private static const DS_ANGLE:Number = 90;
      
      private static const DS_COLOR:uint = 9831174;
      
      private static const DS_ALPHA:Number = 1;
      
      private static const DS_BLUR_X:Number = 12;
      
      private static const DS_BLUR_Y:Number = 12;
      
      private static const DS_STRENGTH:Number = 1.8;
      
      private static const DS_QUALITY:int = 2;
       
      
      public var labelTf:TextField = null;
      
      public var arrowBg:Sprite = null;
      
      public function QuestProgressOrConditionTab()
      {
         var _loc1_:int = 0;
         super();
         this.labelTf.text = PERSONAL_MISSIONS.CONDITIONS_ORGROUP;
         App.utils.commons.updateTextFieldSize(this.labelTf,true,false);
         _loc1_ = this.labelTf.width;
         this.labelTf.x = -_loc1_ >> 1;
         this.arrowBg.width = Math.max(_loc1_ + BG_HORIZONTAL_GAP,MIN_BG_WIDTH);
         App.utils.commons.setShadowFilterWithParams(this.labelTf,DS_DISTANCE,DS_ANGLE,DS_COLOR,DS_ALPHA,DS_BLUR_X,DS_BLUR_Y,DS_STRENGTH,DS_QUALITY);
      }
      
      override protected function onDispose() : void
      {
         this.labelTf = null;
         this.arrowBg = null;
         super.onDispose();
      }
   }
}
