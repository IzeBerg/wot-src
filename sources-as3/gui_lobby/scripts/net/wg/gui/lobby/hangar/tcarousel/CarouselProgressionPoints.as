package net.wg.gui.lobby.hangar.tcarousel
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.carousels.data.ProgressionPointsVO;
   import net.wg.infrastructure.interfaces.entity.IDisplayable;
   import net.wg.utils.ICommons;
   
   public class CarouselProgressionPoints extends Sprite implements IDisplayable
   {
      
      private static const LIMIT_REACHED_TEXT_FILED_ALPHA:Number = 0.3;
      
      private static const SPECIAL_LIMIT_REACHED_TEXT_FILED_ALPHA:Number = 0.5;
      
      private static const LIMIT_TEXT_FILED_ALPHA:Number = 0.4;
      
      private static const VALUE_TEXT_FILED_ALPHA:Number = 0.8;
      
      private static const SPECIAL_TEXT_FILED_ALPHA:Number = 1;
      
      private static const GAP:int = 3;
      
      private static const LABEL_SPECIAL:String = "special";
      
      private static const LABEL_COMMON:String = "common";
       
      
      public var textFieldFirst:TextField = null;
      
      public var textFieldSecond:TextField = null;
      
      public var limitNotReached:MovieClip = null;
      
      public var limitReachedBg:MovieClip = null;
      
      private var _commons:ICommons = null;
      
      private var _intCD:int = -1;
      
      public function CarouselProgressionPoints()
      {
         super();
         this.textFieldFirst.autoSize = TextFieldAutoSize.LEFT;
         this.textFieldSecond.autoSize = TextFieldAutoSize.LEFT;
         this._commons = App.utils.commons;
         addEventListener(MouseEvent.ROLL_OVER,this.onMouseOverHandler);
         addEventListener(MouseEvent.ROLL_OUT,this.onMouseOutHandler);
         buttonMode = true;
         mouseChildren = false;
      }
      
      public function dispose() : void
      {
         removeEventListener(MouseEvent.ROLL_OVER,this.onMouseOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.onMouseOutHandler);
         this.textFieldFirst = null;
         this.textFieldSecond = null;
         this.limitNotReached = null;
         this.limitReachedBg = null;
         this._commons = null;
      }
      
      public function setData(param1:ProgressionPointsVO, param2:int) : void
      {
         this._intCD = param2;
         (!!param1.limitReached ? this.limitReachedBg : this.limitNotReached).gotoAndStop(!!param1.isSpecialVehicle ? LABEL_SPECIAL : LABEL_COMMON);
         this.limitNotReached.visible = !param1.limitReached;
         this.limitReachedBg.visible = param1.limitReached;
         this.textFieldSecond.htmlText = param1.limitPoints;
         this.textFieldFirst.htmlText = param1.currentPoints;
         this._commons.updateTextFieldSize(this.textFieldFirst);
         this._commons.updateTextFieldSize(this.textFieldSecond);
         var _loc3_:int = this.textFieldFirst.width + this.textFieldSecond.width - GAP;
         this.textFieldFirst.x = width - _loc3_ >> 1;
         this.textFieldSecond.x = this.textFieldFirst.x + this.textFieldFirst.width - GAP | 0;
         if(param1.limitReached)
         {
            this.textFieldSecond.alpha = this.textFieldFirst.alpha = !!param1.isSpecialVehicle ? Number(SPECIAL_LIMIT_REACHED_TEXT_FILED_ALPHA) : Number(LIMIT_REACHED_TEXT_FILED_ALPHA);
         }
         else
         {
            this.textFieldFirst.alpha = !!param1.isSpecialVehicle ? Number(SPECIAL_TEXT_FILED_ALPHA) : Number(VALUE_TEXT_FILED_ALPHA);
            this.textFieldSecond.alpha = !!param1.isSpecialVehicle ? Number(SPECIAL_TEXT_FILED_ALPHA) : Number(LIMIT_TEXT_FILED_ALPHA);
         }
      }
      
      private function onMouseOverHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.showWulfTooltip(TOOLTIPS_CONSTANTS.BATTLE_PASS_VEHICLE_POINTS,this._intCD);
      }
      
      private function onMouseOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
   }
}
