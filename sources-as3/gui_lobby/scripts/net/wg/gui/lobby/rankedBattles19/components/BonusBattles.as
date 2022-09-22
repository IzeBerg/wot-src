package net.wg.gui.lobby.rankedBattles19.components
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   
   public class BonusBattles extends UIComponentEx
   {
      
      private static const BONUSBATTLES_WIDTH_DECREASE:int = -200;
      
      private static const ICON_ALIGN_LEFT_GAPS:Object = {
         "left":8,
         "right":5,
         "center":0
      };
      
      private static const ICON_ALIGN_RIGHT_GAPS:Object = {
         "left":5,
         "right":7,
         "center":2
      };
       
      
      public var bonusTf:TextField = null;
      
      public var leftDivider:Sprite = null;
      
      public var rightDivider:Sprite = null;
      
      public var icon:Sprite = null;
      
      public var hit:Sprite = null;
      
      private var _text:String = null;
      
      private var _iconAlign:String = "right";
      
      private var _tooltipMgr:ITooltipMgr;
      
      public function BonusBattles()
      {
         this._tooltipMgr = App.toolTipMgr;
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         useHandCursor = buttonMode = true;
         mouseChildren = false;
         hitArea = this.hit;
         addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         super.draw();
         if(StringUtils.isNotEmpty(this._text))
         {
            if(isInvalid(InvalidationType.DATA))
            {
               this.bonusTf.text = this._text;
               App.utils.commons.updateTextFieldSize(this.bonusTf,true,false);
               invalidateSize();
            }
            if(isInvalid(InvalidationType.SIZE))
            {
               if(this._iconAlign == TextFieldAutoSize.LEFT)
               {
                  _loc1_ = this.bonusTf.width + this.icon.width + ICON_ALIGN_LEFT_GAPS.center >> 1;
                  this.icon.x = -_loc1_;
                  this.bonusTf.x = this.icon.x + this.icon.width + ICON_ALIGN_LEFT_GAPS.center;
                  this.leftDivider.x = -(_loc1_ + this.leftDivider.width + ICON_ALIGN_LEFT_GAPS.left);
                  this.rightDivider.x = _loc1_ + ICON_ALIGN_LEFT_GAPS.right;
               }
               else
               {
                  _loc1_ = this.bonusTf.width + this.icon.width + ICON_ALIGN_RIGHT_GAPS.center >> 1;
                  this.bonusTf.x = -_loc1_;
                  this.icon.x = this.bonusTf.x + this.bonusTf.width + ICON_ALIGN_RIGHT_GAPS.center;
                  this.leftDivider.x = -(_loc1_ + this.leftDivider.width + ICON_ALIGN_RIGHT_GAPS.left);
                  this.rightDivider.x = _loc1_ + ICON_ALIGN_RIGHT_GAPS.right;
               }
               this.hit.width = width + BONUSBATTLES_WIDTH_DECREASE;
               this.hit.x = -(this.hit.width >> 1);
               dispatchEvent(new Event(Event.RESIZE));
            }
         }
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this.bonusTf = null;
         this.leftDivider = null;
         this.rightDivider = null;
         this.icon = null;
         hitArea = null;
         this.hit = null;
         this._tooltipMgr = null;
         super.onDispose();
      }
      
      public function setText(param1:String) : void
      {
         if(this._text != param1)
         {
            this._text = param1;
            invalidateData();
         }
      }
      
      public function set iconAlign(param1:String) : void
      {
         if(StringUtils.isNotEmpty(param1) && this._iconAlign != param1)
         {
            this._iconAlign = param1;
            invalidateSize();
         }
      }
      
      private function onRollOverHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.showSpecial(TOOLTIPS_CONSTANTS.RANKED_BATTLES_BONUS,null);
      }
      
      private function onRollOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
   }
}
